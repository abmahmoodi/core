class GeoLocationPolicy < Struct.new(:user, :geo_location)
  def index?
    Rw::HasType.call(id: user.id, user_type: 'admin').success?
  end

  def create?
    Rw::HasType.call(id: user.id, user_type: 'admin').success?
  end

  def update?
    Rw::HasType.call(id: user.id, user_type: 'admin').success?
  end

  def destroy?
    Rw::HasType.call(id: user.id, user_type: 'admin').success?
  end
end