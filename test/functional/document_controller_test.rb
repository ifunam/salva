require 'salva_controller_test'
require 'document_controller'

class DocumentController; def rescue_action(e) raise e end; end

class  DocumentControllerTest < SalvaControllerTest
   fixtures :documenttypes, :documents

  def initialize(*args)
   super
   @mycontroller =  DocumentController.new
   @myfixtures = { :enddate => '2008-10-01', :title => 2009, :documenttype_id => 1, :startdate => '2009-01-15' }
   @mybadfixtures = {  :enddate => nil, :title => nil, :documenttype_id => nil, :startdate => nil }
   @model = Document
   @quickposts = [ 'documenttype' ]
  end
end
