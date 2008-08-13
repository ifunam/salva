require 'salva_controller_test'
require 'user_journal_controller'

class UserJournalController; def rescue_action(e) raise e end; end

class  UserJournalControllerTest < SalvaControllerTest
   fixtures :countries, :mediatypes, :publishers, :journals, :roleinjournals, :user_journals

  def initialize(*args)
   super
   @mycontroller =  UserJournalController.new
   @myfixtures = { :startyear => 2003, :journal_id => 2, :user_id => 3, :roleinjournal_id => 3 }
   @mybadfixtures = {  :startyear => nil, :journal_id => nil, :user_id => nil, :roleinjournal_id => nil }
   @model = UserJournal
   @quickposts = [ 'journal' ]
  end
end
