require 'salva_controller_test'
require 'chapterinbook_comment_controller'

class ChapterinbookCommentController; def rescue_action(e) raise e end; end

class  ChapterinbookCommentControllerTest < SalvaControllerTest
   fixtures :countries, :booktypes, :books, :editions, :publishers, :mediatypes, :editionstatuses, :bookeditions, :bookchaptertypes, :chapterinbooks, :chapterinbook_comments

  def initialize(*args)
   super
   @mycontroller =  ChapterinbookCommentController.new
   @myfixtures = { :user_id => 1, :chapterinbook_id => 1 }
   @mybadfixtures = {  :user_id => nil, :chapterinbook_id => nil }
   @model = ChapterinbookComment
  end
end
