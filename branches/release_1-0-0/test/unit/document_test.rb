require File.dirname(__FILE__) + '/../test_helper'
require 'documenttype'
require 'document'

class DocumentTest < Test::Unit::TestCase
  fixtures :documenttypes, :documents

  def setup
    @documents = %w(annual_report annual_plan)
    @mydocument = Document.new({:documenttype_id => 2, :title => 'Plan Anual de Actividades 2007', :startdate => '2006-12-01', :enddate => '2007-06-01'})
  end

  # Right - CRUD
  def test_creating_documents_from_yaml
    @documents.each { | document|
      @document = Document.find(documents(document.to_sym).id)
      assert_kind_of Document, @document
      assert_equal documents(document.to_sym).id, @document.id
      assert_equal documents(document.to_sym).documenttype_id, @document.documenttype_id
      assert_equal documents(document.to_sym).title, @document.title
      assert_equal documents(document.to_sym).startdate, @document.startdate
      assert_equal documents(document.to_sym).enddate, @document.enddate
    }
  end

  def test_updating_title
    @documents.each { |document|
      @document = Document.find(documents(document.to_sym).id)
      assert_equal documents(document.to_sym).title, @document.title

      @document.update_attribute('title', @document.title.chars.reverse)
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

  def test_creating_duplicated_document
    @document = Document.new({:documenttype_id => 2, :title => 'Plan Anual de Actividades 2008', :startdate => '2007-11-01', :enddate => '2008-01-01'})
    assert !@document.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mydocument.id = 1.6
    assert !@mydocument.valid?
    @mydocument.id = 'mi_id'
    assert !@mydocument.valid?
  end

  def test_bad_values_for_documenttype_id
    @mydocument.documenttype_id = nil
    assert !@mydocument.valid?

    @mydocument.documenttype_id= 1.6
    assert !@mydocument.valid?

    @mydocument.documenttype_id = 'mi_id'
    assert !@mydocument.valid?
  end

  def test_bad_values_for_documents
    @mydocument.startdate = nil
    assert !@mydocument.valid?
    @mydocument.enddate = nil
    assert !@mydocument.valid?

    @mydocument.startdate = '1976-06-01'
    @mydocument.enddate = '1966-12-20'
    assert !@mydocument.valid?
  end


   #Cross-Checking test

  def test_cross_checking_for_documenttype_id
    @documents.each { | document|
      @document = Document.find(documents(document.to_sym).id)

      assert_kind_of Document, @document
      assert_equal @document.documenttype_id, Documenttype.find(@document.documenttype_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_documenttype_id
    @documents.each { | document|
      @document = Document.find(documents(document.to_sym).id)
      assert_kind_of Document, @document
      @document.documenttype_id = 100000
      begin
        return true if @document.save
      rescue StandardError => x
        return false
      end
    }
  end

end
