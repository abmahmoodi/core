class AgentCityPolicy < Struct.new(:user, :agent_citys)
  def index?
    user.admin? || user.support?
  end

  def create_agent_city?
    user.admin? || user.support?
  end

  def destroy_agent_city?
    user.admin? || user.support?
  end

  def agent_city_datatable?
    user.admin? || user.support?
  end

  def create?
    user.admin? || user.support?
  end

  def update?
    user.admin? || user.support?
  end
end