module Rw
  class HasType
    include Interactor

    def call
      result = Rw::User.joins('LEFT JOIN rw_user_types ut ON ut.code = rw_users.user_type').
          where('rw_users.id=? AND ut.title=?', context.id, context.user_type).take
      if result.nil?
        context.fail!
      end
    end
  end
end