class InstitutionsController < ApplicationController
  respond_to :text, :only => [:autocomplete_name]
  respond_to :js, :only => [:show]
  def autocomplete_name
    @records = Institution.tagged_search params[:q]
    @items= @records.collect do |record|
       [record[:name], record[:id]].join('|')
     end
    render :text => @items.join("\n")
  end

  def show
     respond_with(@institution = Institution.find(params[:id]))
  end
end
