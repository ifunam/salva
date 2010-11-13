class InstitutionsController < CatalogController

  def search_by_name
    @records = Institution.search_for_autocomplete params[:term]
    @results = @records.collect { |record| {:id => record.id, :value => record.name, :label => record.name} }
    render :json => @results
  end

end
