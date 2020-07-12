class UserPolicy < Struct.new(:user, :mobile_device)
  def index?
    user.admin? || user.building_manager
  end

  def create_user?
    user.admin? || user.building_manager
  end

  def destroy_user?
    user.admin? || user.building_manager
  end

  def user_datatable?
    user.admin? || user.building_manager
  end
end