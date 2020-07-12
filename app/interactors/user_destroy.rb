class UserDestroy
  include Interactor

  def call
    raise I18n.t(:'messages.permission_denied') unless UserPolicy.new(context.user, :user).destroy_user?
    if context.id == 0
      context.fail!
      context.error = I18n.t(:'messages.no_selection')
    else
      ids = context.id.split(',').to_a
      ActiveRecord::Base.transaction do
        unless Rw::Profile.where('user_id in (?)', ids).delete_all &&
            Rw::User.where('id in (?)', ids).delete_all
          context.fail!
          context.error = 'خطا'
        end
      end
    end
  end
end
