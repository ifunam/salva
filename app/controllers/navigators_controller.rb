class NavigatorsController < ApplicationController
layout 'navigator'
  def show
    @items = Tree.find(:all)
    @item = Tree.find(:first)
    # select according to your choice...
    #this item will be selected node by default in the tree when it will first be loaded.
  end

  def display_clicked_branch
    respond_to do |format|
      @item = Tree.find(params[:id]) rescue nil
      format.js { render :action => 'branch.rjs'}
    end
  end
end
