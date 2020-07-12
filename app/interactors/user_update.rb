class UserUpdate
  include Interactor

  def call
    # raise I18n.t(:'messages.permission_denied') unless UserPolicy.new(context.view.current_user, :user).create_user?
    user = Rw::User.find(context.data[:id])
    user_form = UserEditForm.new(user)

    if user_form.validate(context.data)
      user_form.save
      context.user = user_form
    else
      context.user = user_form
      context.fail!
    end
  end
end
