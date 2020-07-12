class UserCreate
  include Interactor

  def call
    Rw::Authorize.call(context.current_user, UserPolicy, :create_user?)

    if context.user.validate(context.data)
      context.user.save

      if context.current_user.building_manager?
        building_user = BuildingUserForm.new(Rw::Panel::BuildingUser.new)
        building_id = Rw::Panel::BuildingManager.where(manager_id: context.current_user.id).pluck(:building_id)[0]
        if building_user.validate(building_id: building_id, user_id: context.user.id)
          building_user.save
        end
      end
      context.current_user = Rw::User.find_by(email: context.data[:email])
    else
      context.fail!
    end
  end
end
