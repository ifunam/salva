require 'salva_controller_test'
require 'user_inproceeding_controller'

class UserInproceedingController; def rescue_action(e) raise e end; end

class  UserInproceedingControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings, :user_inproceedings

  def initialize(*args)
   super
   @mycontroller =  UserInproceedingController.new
   @myfixtures = { :inproceeding_id => 2, :ismainauthor => 'true_test' }
   @mybadfixtures = {  :inproceeding_id => nil, :ismainauthor => nil }
   @model = UserInproceeding
   @quickposts = [ 'inproceeding' ]
  end
end
