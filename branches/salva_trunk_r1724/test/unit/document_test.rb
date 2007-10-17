require File.dirname(__FILE__) + '/../test_helper'
require 'documenttype'
require 'document'

class DocumentTest < Test::Unit::TestCase
  fixtures :documenttypes, :documents

  def setup
    @documents = %w(annual_report annual_plan)
    @mydocument = Document.new({ :title => 2008,  :documenttype_id => 1, :startdate => '2009-01-15', :enddate => '2008-10-01' })
  end

  # Right - CRUD
  def test_creating_documents_from_yaml
    @documents.each { | document|
      @document = Document.find(documents(document.to_sym).id)
      assert_kind_of Document, @document
      assert_equal documents(document.to_sym).id, @document.id
      assert_equal documents(document.to_sym).title, @document.title
      assert_equal documents(document.to_sym).documenttype_id, @document.documenttype_id
    }
  end

  def test_updating_documents_title
    @documents.each { |document|
      @document = Document.find(documents(document.to_sym).id)
      assert_equal documents(document.to_sym).title, @document.title
      @document.title = @document.title.chars.reverse
      assert @document.update
      assert_not_equal documents(document.to_sym).title, @document.title
    }
  end

  def test_deleting_documents
    @documents.each { |document|
      @document = Document.find(documents(document.to_sym).id)
      @document.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Document.find(documents(document.to_sym).id)
      }
    }
  end

   def test_creating_with_empty_attributes
     @document = Document.new
     assert !@document.save
   end

  def test_validate_uniqueness
    @document = Document.new({:title => '2007', :documenttype_id => 1})
    @document.id = 1
    assert !@document.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mydocument.id = 1.6
    assert !@mydocument.valid?

    @mydocument.id = 'x'
    assert !@mydocument.valid?
  end

 def test_bad_values_for_title
   @mydocument.title = nil
   assert !@mydocument.valid?
 end

  def test_bad_values_for_documenttype_id
    @mydocument.documenttype_id = nil
    assert !@mydocument.valid?
    @mydocument.documenttype_id = 3.1416
    assert !@mydocument.valid?
    @mydocument.documenttype_id = 'mi_id'
    assert !@mydocument.valid?
  end

   def test_cross_checking_for_documenttype_id
     @documents.each { | document|
       @document = Document.find(documents(document.to_sym).id)
       assert_kind_of Document, @document
       assert_equal @document.documenttype_id, Documenttype.find(@document.documenttype_id).id
     }
   end

  def test_cross_checking_with_bad_values_for_documenttype_id
    @documents.each { | document|
      @document = Document.find(documents(document.to_sym).id)
      assert_kind_of Document, @document
      @document.documenttype_id = 10
      begin
        return true if @document.update
      rescue StandardError => x
        return false
      end
    }
 end
end
