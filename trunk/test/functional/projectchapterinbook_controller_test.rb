require 'salva_controller_test'
require 'projectchapterinbook_controller'

class ProjectchapterinbookController; def rescue_action(e) raise e end; end

class  ProjectchapterinbookControllerTest < SalvaControllerTest
fixtures  :editionstatuses, :editions, :mediatypes, :projecttypes,:projectstatuses,:projects,:countries, :booktypes, :books, :bookeditions, :bookchaptertypes, :chapterinbooks, :projectchapterinbooks

  def initialize(*args)
   super
   @mycontroller =  ProjectchapterinbookController.new
   @myfixtures = {:project_id => 2, :chapterinbook_id =>2}
   @mybadfixtures = {  :project_id => nil, :chapterinbook_id =>nil }
   @model = Projectchapterinbook
  end
end
