class Admin::CitiesController < ApplicationController
  layout 'catalogs'
  respond_to :html
  respond_to :js, :only => [:transfer_association, :transfer_all_associations, :show, :index]
  def index
    respond_with(@cities = City.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => 10))
  end

  # TODO: Implement new, create and edit, destroy_all_with_empty_associations actions
  
  def update
    @city = City.find(params[:id])
    @city.update_attributes(params[:city])
    respond_with(@cities, :status => :updated, :location => admin_city_path) 
  end

  def show
    respond_with(@city = City.find(params[:id]))
  end

  def destroy
    @city = City.find(params[:id])
    @city.destroy
    respond_with(@city, :status => :deleted, :location => admin_cities_path)
  end

  def destroy_all
    params[:ids].each { |id| City.find(id).destroy }
    redirect_to admin_cities_path
  end
    
  def transfer_association
    @city = City.find(params[:id])
    association_name = params[:association_name]
    if @city.respond_to? association_name
      @city.send(association_name).each { |record| record.update_attributes(:city_id => params[:new_id]) }
    end
    @updated_city = City.find(params[:new_id])
    respond_with(@updated_city, :status => :updated) 
  end

  def transfer_all_associations
    @city = City.find(params[:id])
    @city.class.reflect_on_all_associations(:has_many).collect do |association|
      @city.send(association.name).each { |record| record.update_attributes(:city_id => params[:new_id]) }
    end
    @updated_city = City.find(params[:new_id])
    respond_with(@updated_city, :status => :updated)     
  end
end