require 'salva_controller_test'
require 'user_inproceeding_unrefereed_controller'

class UserInproceedingUnrefereedController; def rescue_action(e) raise e end; end

class  UserInproceedingUnrefereedControllerTest < SalvaControllerTest
   fixtures  :countries, :conferencetypes, :conferencescopes, :conferences, :proceedings, :inproceedings, :user_inproceedings

  def initialize(*args)
   super
   @mycontroller =  UserInproceedingUnrefereedController.new
   @myfixtures = { :inproceeding_id => 2, :ismainauthor => 'true_test' }
   @mybadfixtures = {  :inproceeding_id => nil, :ismainauthor => nil }
   @model = UserInproceeding
   @quickposts = [ 'inproceeding_unrefereed,iproceeding_id' ]
  end
end
