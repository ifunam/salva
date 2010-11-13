class JournalsController < CatalogController 

  def search_by_name
    @records = Journal.search(:name_starts_with => params[:term]).all
    @results = @records.collect { |record| {:id => record.id, :value => record.name, :label => record.name} }
    render :json => @results
  end

end