class JournalsController < InheritedResources::Base
  respond_to :json, :only => [:search_by_name]
  respond_to :js, :only => [:autocomplete_form, :create, :new, :show]

  def search_by_name
    @records = Journal.search(:name_starts_with => params[:term]).all
    @results = @records.collect { |record| {:id => record.id, :value => record.name, :label => record.name} }
    render :json => @results
  end
  
  def autocomplete_form
     render :action => 'autocomplete_form.js'
  end
  
  def create
     create! do |format|
       format.js { render :action => 'show.js' }
     end
  end
end