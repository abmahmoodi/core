class AssignUserType
  include Interactor

  def call
    user_type_id = Rw::UserType.where(title: 'collector').pluck(:id)[0]
    if context.user_type_id.to_i == user_type_id
      user = Rw::User.where('id = ?', context.user_id).take
      if user.code
        Rw::User.where('id = ?', context.user_id).update_all(user_type: context.user_type_id)
      else
        user_code = GenerateCodeForUser.call.code
        Rw::User.where('id = ?', context.user_id).update_all(user_type: context.user_type_id, code: user_code)
      end
    else
      Rw::User.where(id: context.user_id).update_all(user_type: context.user_type_id)
    end
  end
end