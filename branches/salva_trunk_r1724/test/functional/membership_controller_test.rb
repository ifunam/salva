require 'salva_controller_test'
require 'membership_controller'

class MembershipController; def rescue_action(e) raise e end; end

class  MembershipControllerTest < SalvaControllerTest
  fixtures :users, :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :memberships


  def initialize(*args)
   super
   @mycontroller =  MembershipController.new
   @myfixtures = {:user_id => 3, :institution_id => 1}
   @mybadfixtures = { :user_id => 3, :institution_id => nil }
   @model = Membership
   @quickpost = ['institution']
  end
end
