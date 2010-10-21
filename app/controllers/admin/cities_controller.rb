class Admin::CitiesController < ApplicationController
  layout 'catalogs'
  respond_to :html
  respond_to :js, :only => [:move_association, :move_associations, :show, :index]

  def index
    respond_with(@cities = City.search(params[:search]).paginate(:page => params[:page] || 1, :per_page => params[:per_page] || 10))
  end

  def new
    respond_with(@city = City.new)
  end

  def create
    respond_with(@city = City.create(params[:city]), :status => :created) do |format|
      format.html { render :action => 'show' }
    end 
  end

  def show
    respond_with(@city = City.find(params[:id]))
  end

  def edit
    respond_with(@city = City.find(params[:id]))
  end

  def update
    @city = City.find(params[:id])
    @city.update_attributes(params[:city])
    respond_with(@cities, :status => :updated, :location => admin_city_path) 
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

  def destroy_all_empty_associations
    City.destroy_all_with_empty_associations
    redirect_to admin_cities_path
  end

  def move_association
    @city = City.find(params[:id])
    @city.move_association(params[:association_name], params[:new_id])
    @updated_city = City.find(params[:new_id])
    respond_with(@updated_city, :status => :updated) 
  end

  def move_associations
    @city = City.find(params[:id])
    @city.move_associations(params[:new_id])
    @updated_city = City.find(params[:new_id])
    respond_with(@updated_city, :status => :updated)     
  end
end