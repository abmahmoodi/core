class AgentCityForm < Reform::Form
  model 'rw/agent_city'
  property :user_id
  property :geo_location_id
end