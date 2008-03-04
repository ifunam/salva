require 'salva_controller_test'
require 'period_controller'

class PeriodController; def rescue_action(e) raise e end; end

class  PeriodControllerTest < SalvaControllerTest
  fixtures :periods

  def initialize(*args)
   super
   @mycontroller =  PeriodController.new
   @myfixtures = { :title =>  'Ordinario_prueba', :startdate =>  '2006-06-01', :enddate => '2006-12-10'}
   @mybadfixtures = {   :title =>  nil, :startdate =>  nil, :enddate => '2006-12-10 '}
   @model = Period
  end
end
