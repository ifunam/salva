class InstitutionsController < InheritedResources::Base
  respond_to :text, :only => [:autocomplete_name]
  respond_to :js, :only => [:show, :new, :autocomplete_form]

  def autocomplete_name
    @records = Institution.search_for_autocomplete params[:q]
    @items= @records.collect do |record|
      [record.name, record.id].join('|')
    end
    render :text => @items.join("\n")
  end
  
  def autocomplete_form
     render :action => 'autocomplete_form.js'
  end
  
  def create
    create! do |format|
      format.js { render :action => 'create.js' }
    end
  end
end
