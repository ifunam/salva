require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'chapterinbook'
require 'projectchapterinbook'

class ProjectchapterinbookTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :countries, :bookchaptertypes, :booktypes, :books, :editions, :publishers, :mediatypes, :editionstatuses, :bookeditions,:chapterinbooks, :projectchapterinbooks

  def setup
    @projectchapterinbooks = %w(la_atmosfera_de_Venus la_superficie_de_la_tierra)
    @myprojectchapterinbook = Projectchapterinbook.new({:project_id => 2, :chapterinbook_id => 2})
  end

  # Right - CRUD
  def test_creating_projectchapterinbooks_from_yaml
    @projectchapterinbooks.each { | projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      assert_kind_of Projectchapterinbook, @projectchapterinbook
      assert_equal projectchapterinbooks(projectchapterinbook.to_sym).id, @projectchapterinbook.id
      assert_equal projectchapterinbooks(projectchapterinbook.to_sym).chapterinbook_id, @projectchapterinbook.chapterinbook_id
      assert_equal projectchapterinbooks(projectchapterinbook.to_sym).project_id, @projectchapterinbook.project_id
    }
  end

  def test_deleting_projectchapterinbooks
    @projectchapterinbooks.each { |projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      @projectchapterinbook.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectchapterinbook = Projectchapterinbook.new
    assert !@projectchapterinbook.save
  end

  def test_creating_duplicated_projectchapterinbook
    @projectchapterinbook = Projectchapterinbook.new({:project_id => 3, :chapterinbook_id => 2})
    assert !@projectchapterinbook.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectchapterinbook.id = 1.6
    assert !@myprojectchapterinbook.valid?
    @myprojectchapterinbook.id = 'mi_id'
    assert !@myprojectchapterinbook.valid?
  end

  def test_bad_values_for_chapterinbook_id
    @myprojectchapterinbook.chapterinbook_id = nil
    assert !@myprojectchapterinbook.valid?

    @myprojectchapterinbook.chapterinbook_id= 1.6
    assert !@myprojectchapterinbook.valid?

    @myprojectchapterinbook.chapterinbook_id = 'mi_id'
    assert !@myprojectchapterinbook.valid?
  end

  def test_bad_values_for_project_id
    @myprojectchapterinbook.project_id = nil
    assert !@myprojectchapterinbook.valid?

    @myprojectchapterinbook.project_id = 3.1416
    assert !@myprojectchapterinbook.valid?
    @myprojectchapterinbook.project_id = 'mi_id'
    assert !@myprojectchapterinbook.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectchapterinbooks.each { | projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      assert_kind_of Projectchapterinbook, @projectchapterinbook
      assert_equal @projectchapterinbook.project_id, Project.find(@projectchapterinbook.project_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_project_id
    @projectchapterinbooks.each { | projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      assert_kind_of Projectchapterinbook, @projectchapterinbook
      @projectchapterinbook.project_id = 1000000
      begin
        return true if @projectchapterinbook.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_chapterinbook_id
    @projectchapterinbooks.each { | projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)

      assert_kind_of Projectchapterinbook, @projectchapterinbook
      assert_equal @projectchapterinbook.chapterinbook_id, Chapterinbook.find(@projectchapterinbook.chapterinbook_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_chapterinbook_id
    @projectchapterinbooks.each { | projectchapterinbook|
      @projectchapterinbook = Projectchapterinbook.find(projectchapterinbooks(projectchapterinbook.to_sym).id)
      assert_kind_of Projectchapterinbook, @projectchapterinbook
      @projectchapterinbook.chapterinbook_id = 100000
      begin
        return true if @projectchapterinbook.save
      rescue StandardError => x
        return false
      end
    }
  end

end
