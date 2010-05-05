class JobpositioncategoriesController < ApplicationController
  def filtered_select
    render :partial => 'select', :layout => false
  end
end
