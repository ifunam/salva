require 'salva_controller_test'
require 'chapterinbook_controller'

class ChapterinbookController; def rescue_action(e) raise e end; end

class  ChapterinbookControllerTest < SalvaControllerTest
fixtures  :countries, :editionstatuses, :editions, :mediatypes,:booktypes, :books, :bookeditions, :bookchaptertypes, :chapterinbooks

  def initialize(*args)
   super
   @mycontroller =  ChapterinbookController.new
   @myfixtures = {  :bookedition_id => 1, :bookchaptertype_id => 3, :title => 'Fuerzas sobre la Atmosfera de Venus _prueba' }
   @mybadfixtures = { :bookedition_id => 1, :bookchaptertype_id => nil, :title => nil }
   @model = Chapterinbook
   @quickposts = ['bookchaptertype']
  end
end
