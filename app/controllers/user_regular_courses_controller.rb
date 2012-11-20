class UserRegularCoursesController < ApplicationController
  respond_to :js

  def new
    @regular_course = Regularcourse.find(params[:id])
    @user_regular_course = UserRegularcourse.new
    @user_regular_course.regularcourse_id = @regular_course.id
    @user_regular_course.user_id = current_user.id
    respond_with(@user_regular_course)
  end

  def create
    @user_regular_course = UserRegularcourse.create(params[:user_regular_course].merge(:registered_by_id => current_user.id))
    if @user_regular_course
      render :action => 'create'
    else
      render :nothing => true
    end
  end

  def destroy
    @user_regular_course = UserRegularcourse.find(params[:id])
    @user_regular_course.destroy
    respond_with(@user_regular_course)
  end
end
