module Rw
  class ServerSideDatatable
    def initialize(view, model, sortable_columns)
      @view = view
      @model = model
      @sortable_columns = sortable_columns
    end

    def as_json(data, options = {})
      {
          sEcho: @view.params[:sEcho].to_i,
          iTotalRecords: count,
          iTotalDisplayRecords: count,
          aaData: data
      }
    end

    def count
      fetch_model.count
    end

    def fetch_model
      result = @model.order("#{sort_column} #{sort_direction}")
      result.page(page).per_page(per_page)
    end

    private

    def page
      @view.params[:iDisplayStart].to_i / per_page + 1
    end

    def per_page
      @view.params[:iDisplayLength].to_i > 0 ? @view.params[:iDisplayLength].to_i : 10
    end

    def sort_column
      columns = @sortable_columns
      columns[@view.params[:iSortCol_0].to_i]
    end

    def sort_direction
      @view.params[:sSortDir_0] == 'desc' ? 'desc' : 'asc'
    end
  end
end