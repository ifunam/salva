require 'salva_controller_test'
require 'bookedition_comment_controller'

class BookeditionCommentController; def rescue_action(e) raise e end; end

class  BookeditionCommentControllerTest < SalvaControllerTest
   fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions , :countries, :booktypes, :books, :editions, :mediatypes, :editionstatuses, :bookeditions, :bookedition_comments

  def initialize(*args)
   super
   @mycontroller =  BookeditionCommentController.new
   @myfixtures = { :bookedition_id => 1, :user_id => 1 }
   @mybadfixtures = {  :bookedition_id => nil, :user_id => nil }
   @model = BookeditionComment
  end
end
