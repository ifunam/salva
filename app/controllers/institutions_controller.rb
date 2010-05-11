class InstitutionsController < InheritedResources::Base
  respond_to :text, :only => [:autocomplete_name]
  respond_to :js, :only => [:show, :new]

  def autocomplete_name
    @records = Institution.tagged_search params[:q]
    @items= @records.collect do |record|
      [record[:name], record[:id]].join('|')
    end
    render :text => @items.join("\n")
  end
  
  def create
    create! do |format|
      format.js { render :action => 'create.js' }
    end
  end
end
