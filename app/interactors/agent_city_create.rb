class AgentCityCreate
  include Interactor

  def call
    Rw::Authorize.call(context.user, AgentCityPolicy, :create?)
    agent_city = AgentCityForm.new(Rw::AgentCity.new)
    if agent_city.validate(context.agent_city_data)
      agent_city.save
    else
      context.agent_city = agent_city
      context.fail!
    end
  end
end
