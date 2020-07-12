module Rw
  class UserToken
    include Interactor

    def call
      context.user_info = Rw::User.
          joins('LEFT JOIN rw_profiles p ON p.user_id = rw_users.id').
          joins(:branches).
          select("rw_users.auth_token, concat(p.first_name, ' ', p.last_name) full_name,
                  rw_branches_branches.geo_location_id, rw_branches_branches.code branch_code").
          where(email: context.email).take
    end
  end
end