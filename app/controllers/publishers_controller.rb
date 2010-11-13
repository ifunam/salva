class PublishersController < CatalogController 
 
  def search_by_name
    @records = Publisher.search(:name_like_ignore_case_ => params[:term]).all
    @results = @records.collect { |record| {:id => record.id, :value => record.name, :label => record.name} }
    render :json => @results
  end

end