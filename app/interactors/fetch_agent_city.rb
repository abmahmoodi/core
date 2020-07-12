class FetchAgentCity
  include Interactor

  def call
    raise I18n.t(:'messages.permission_denied') unless AgentCityPolicy.new(context.view.current_user, :user).agent_city_datatable?

    agent_cities = Rw::AgentCity
                       .joins('inner join rw_geo_locations gl on gl.id = rw_agent_cities.geo_location_id')
                       .select("'' as row, rw_agent_cities.*,gl.title geo_location_title")
                       .where('rw_agent_cities.user_id = ?', context.user_id)

    if context.view.params[:sSearch].present?
      agent_cities = agent_cities.where('gl.title LIKE :search',
                                        search: "%#{context.view.params[:sSearch]}%")
    end

    agent_cities_datatable = Rw::ServerSideDatatable.new(context.view, agent_cities, %w[row gl.title])
    agent_cities = agent_cities_datatable.fetch_model

    hash_agent_cities =
        agent_cities.map do |agent_city|
          [
              agent_city.row,
              agent_city.geo_location_title,
              context.view.link_to("<i class='fa fa-trash fa-lg'></i>".html_safe,
                                   "/destroy_agent_city?id=#{agent_city.id}&user_id=#{context.user_id}",
                                   method: :delete,
                                   class: 'btn btn-danger btn-sm',
                                   id: 'delete-action-geo-location',
                                   data: {confirm: I18n.t(:'messages.r_u_sure')}, remote: true, title: I18n.t(:'titles.destroy')),
              agent_city.id
          ]
        end
    context.result = agent_cities_datatable.as_json(hash_agent_cities)
  end

end
