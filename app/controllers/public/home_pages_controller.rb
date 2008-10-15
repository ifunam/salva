class Public::HomePagesController < ActionController::Base

  def show
    @record=User.find(params[:id])
    respond_to do |format|
      format.html { render :action => 'show'}
    end
  end

  #alias_method :show, :index
end
