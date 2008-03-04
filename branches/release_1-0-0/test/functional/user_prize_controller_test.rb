require 'salva_controller_test'
require 'user_prize_controller'

class UserPrizeController; def rescue_action(e) raise e end; end

class  UserPrizeControllerTest < SalvaControllerTest
   fixtures :prizetypes, :countries, :states, :cities, :institutiontypes, :institutiontitles, :institutions, :prizes, :user_prizes

  def initialize(*args)
   super
   @mycontroller =  UserPrizeController.new
   @myfixtures = { :month => 12, :prize_id => 2, :year => 2006, :user_id => 2 }
   @mybadfixtures = {  :month => nil, :prize_id => nil, :year => nil, :user_id => nil }
   @model = UserPrize
  end
end
