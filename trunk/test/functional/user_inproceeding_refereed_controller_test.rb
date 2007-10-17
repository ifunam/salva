require 'salva_controller_test'
require 'user_inproceeding_refereed_controller'

class UserInproceedingRefereedController; def rescue_action(e) raise e end; end

class  UserInproceedingRefereedControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings, :user_inproceedings

  def initialize(*args)
   super
   @mycontroller =  UserInproceedingRefereedController.new
   @myfixtures = { :inproceeding_id => 2, :ismainauthor => 'true_test' }
   @mybadfixtures = {  :inproceeding_id => nil, :ismainauthor => nil }
   @model = UserInproceeding
   @quickposts = [ 'inproceeding_refereed,inproceeding_id' ]
  end
end
