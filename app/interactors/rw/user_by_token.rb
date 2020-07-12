module Rw
  class UserByToken
    include Interactor

    def call
      user = Rw::User.where(auth_token: context.auth_token).take
      if user
        context.current_user = user
      else
        context.fail!
      end
    end
  end
end
