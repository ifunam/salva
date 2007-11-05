require File.dirname(__FILE__) + '/../test_helper'
require 'person_controller'

class PersonController; def rescue_action(e) raise e end; end

class PersonControllerTest < Test::Unit::TestCase
   include Session
  fixtures :userstatuses, :users, :countries, :states, :cities, :maritalstatuses, :people

  def setup
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    login_as('juana','maltiempo')
    @controller = PersonController.new
  end

  def test_get_new
    get :new
    assert_response :success
    assert_template 'new'
  end

  def test_get_show
    get :show
    assert_response :success
    assert_template 'show'
  end

  def test_get_edit
    get :edit
    assert_response :success
    assert_template 'edit'
  end

  def test_post_create
    @user = Person.find(session[:user])
    @user.destroy
    post :create, :edit => { 'firstname' => 'Roberto', 'lastname1' => 'Mendizabal', 'lastname2' => 'Cantú', 'maritalstatus_id' => 2,
                              "dateofbirth(1i)"=>"1977", "dateofbirth(2i)"=>"10", "gender"=>"true", "dateofbirth(3i)"=>"29",
                              'country_id' => 484, 'state_id' => 9, 'city_id' => 64, 'photo' => nil }
    assert_response :success
    assert_template 'show'
  end

  def test_post_create_with_image
    @user = Person.find(session[:user])
    @user.destroy
    post :create, :edit => { 'firstname' => 'Roberto', 'lastname1' => 'Mendizabal', 'lastname2' => 'Cantú', 'maritalstatus_id' => 2,
                            "dateofbirth(1i)"=>"1977", "dateofbirth(2i)"=>"10", "gender"=>"true", "dateofbirth(3i)"=>"29",
                            'country_id' => 484, 'state_id' => 9, 'city_id' => 64, 'photo' => fixture_file_upload('comodin.png', 'image/png')}
    assert_response :success
    assert_template 'show'
  end

  def test_post_update
    post :update, :edit => { 'firstname' => 'Roberto', 'lastname1' => 'Mendizabal', 'lastname2' => 'Cantú', 'maritalstatus_id' => 2,
                              "dateofbirth(1i)"=>"1977", "dateofbirth(2i)"=>"10", "gender"=>"true", "dateofbirth(3i)"=>"29",
                              'country_id' => 484, 'state_id' => 9, 'city_id' => 64, 'photo' => nil }, :id => 2
    assert_response :success
    assert_template 'show'
  end

  def test_post_update_with_image
    post :update, :id => 2,:edit => { 'firstname' => 'Roberto', 'lastname1' => 'Mendizabal', 'lastname2' => 'Cantú', 'maritalstatus_id' => 2,
                              "dateofbirth(1i)"=>"1977", "dateofbirth(2i)"=>"10", "gender"=>"true", "dateofbirth(3i)"=>"29",
                              'country_id' => 484, 'state_id' => 9, 'city_id' => 64, 'photo' => fixture_file_upload('comodin.png', 'image/png')}
    assert_response :success
    assert_template 'show'
  end

  def test_should_not_update_data_of_another_user_record
    post :update, :edit => { 'firstname' => 'Roberto', 'lastname1' => 'Mendizabal', 'lastname2' => 'Cantú', 'maritalstatus_id' => 2,
                              "dateofbirth(1i)"=>"1977", "dateofbirth(2i)"=>"10", "gender"=>"true", "dateofbirth(3i)"=>"29",
                              'country_id' => 484, 'state_id' => 9, 'city_id' => 64, 'photo' => nil }, :id => 3
    assert_response :redirect
    assert_redirected_to :action => :index
    assert_equal 'Usted no puede modificar la información de otro usuario', flash[:notice]
  end
end
