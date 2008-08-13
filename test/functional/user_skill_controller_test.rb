require 'salva_controller_test'
require 'user_skill_controller'

class UserSkillController; def rescue_action(e) raise e end; end

class  UserSkillControllerTest < SalvaControllerTest
  fixtures :users, :skilltypes, :user_skills


  def initialize(*args)
   super
   @mycontroller =  UserSkillController.new
   @myfixtures = {  :user_id =>  3, :skilltype_id => 3}
   @mybadfixtures = {:user_id =>  3, :skilltype_id =>nil }
   @model = UserSkill
   @quickposts = ['skilltype']
  end
end
