require 'salva_controller_test'
require 'chapterinbook_roleinchapter_controller'

class ChapterinbookRoleinchapterController; def rescue_action(e) raise e end; end

class  ChapterinbookRoleinchapterControllerTest < SalvaControllerTest
  

  def initialize(*args)
   super
   @mycontroller =  ChapterinbookRoleinchapterController.new
   @myfixtures = {}
   @mybadfixtures = {   }
   @model = ChapterinbookRoleinchapter
  end
end
