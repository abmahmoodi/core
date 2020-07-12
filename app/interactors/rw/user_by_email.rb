module Rw
  class UserByEmail
    include Interactor

    def call
      user = Rw::User.left_joins(:profile).where('email = ?', context.email)
      if user
        context.result = user
      else
        context.fail!
      end
    end
  end
end
