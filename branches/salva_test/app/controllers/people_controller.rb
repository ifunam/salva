class PeopleController < ApplicationController
  def index
  end
  
  def new
   @edit = Person.new
  end 
end
