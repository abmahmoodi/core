module Rw
  class FetchUserByType
    include Interactor
    SELECT_SQL = <<-SQL
        rw_users.id,Concat(rw_profiles.first_name,' ',rw_profiles.last_name) full_name
    SQL

    def call
      context.users = Rw::User.joins('LEFT JOIN rw_user_types ut ON ut.code = rw_users.user_type')
                          .joins(:profile).select(SELECT_SQL).where('ut.title = ?', context.user_type.to_s)
    end
  end
end