require 'salva_controller_test'
require 'journal_controller'

class JournalController; def rescue_action(e) raise e end; end

class  JournalControllerTest < SalvaControllerTest
   fixtures :countries, :mediatypes, :publishers, :journals

  def initialize(*args)
   super
   @mycontroller =  JournalController.new
   @myfixtures = { :name => 'QUO_test', :country_id => 484, :mediatype_id => 2, :publisher_id => 2 }
   @mybadfixtures = {  :name => nil, :abbrev => nil, :country_id => nil, :url => nil, :issn => nil, :mediatype_id => nil, :publisher_id => nil, :other => nil }
   @model = Journal
   @quickposts = [ 'publisher' ]
  end
end
