class FetchUsers
  include Interactor

  def call
    raise I18n.t(:'messages.permission_denied') unless UserPolicy.new(context.view.current_user, :user).user_datatable?

    user_ids = []
    admin = 0
    if context.view.current_user.admin?
      admin = 1
    else
      building_id = Rw::Panel::BuildingManager.where(manager_id: context.view.current_user.id).pluck(:building_id)[0]
      user_ids = Rw::Panel::BuildingUser.where(building_id: building_id).pluck(:user_id)
    end

    users = Rw::User.joins('LEFT JOIN rw_user_types ut ON ut.code = rw_users.user_type').
        joins('LEFT JOIN rw_profiles ON rw_profiles.user_id = rw_users.id').
        select("'' as row, rw_users.id, rw_users.code, rw_users.email, ut.persian_title,
                concat(rw_profiles.first_name, ' ', rw_profiles.last_name) full_name, rw_users.login_count,
                rw_users.last_login_at, rw_users.user_type").where('rw_users.id IN (?) OR 1 = ? OR rw_users.id = ?',
                                                                   user_ids, admin, context.view.current_user.id)
    if context.view.params[:sSearch].present?
      users = users.where('rw_users.email LIKE :search OR ut.title LIKE :search OR rw_profiles.first_name LIKE :search
                           OR rw_profiles.last_name LIKE :search',
                          search: "%#{context.view.params[:sSearch]}%")
    end

    user_datatable = Rw::ServerSideDatatable.new(
        context.view,
        users,
        %w[row code email persian_title full_name last_login_at login_count])
    users = user_datatable.fetch_model

    hash_users =
        users.map do |user|
          [
              user.row,
              user.code,
              user.email,
              user.persian_title,
              user.full_name,
              last_login(user.last_login_at),
              user.login_count,
              city_link(user),
              user.id
          ]
        end
    context.result = user_datatable.as_json(hash_users)
  end

  private

  def last_login(date_time)
    Rw::GregorianToJalali.call(date_time: date_time.in_time_zone('Tehran')).jalali_date.strftime('%Y/%m/%d') + ' - ' +
        date_time.in_time_zone('Tehran').strftime('%H:%M') if date_time
  end

  def city_link(user)
    if user.user_type == 3
      context.view.link_to("<i class='fa fa-edit'></i>".html_safe,
                           context.view.rw.agent_city_path(user_id: user.id),
                           remote: true, title: I18n.t(:'users.agent_city'))
    else
      ''
    end
  end
end