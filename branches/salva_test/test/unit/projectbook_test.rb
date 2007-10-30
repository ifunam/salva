require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'book'
require 'projectbook'

class ProjectbookTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects, :countries, :booktypes, :books, :projectbooks

  def setup
    @projectbooks = %w(introduccion_al_estudio_de_planetas Fundamentos_sobre_estudios_de_la_tierra Fundamentos_sobre_movimientos_tectonicos_de_la_tierra)
    @myprojectbook = Projectbook.new({:project_id => 2, :book_id => 1})
  end

  # Right - CRUD
  def test_creating_projectbooks_from_yaml
    @projectbooks.each { | projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)
      assert_kind_of Projectbook, @projectbook
      assert_equal projectbooks(projectbook.to_sym).id, @projectbook.id
      assert_equal projectbooks(projectbook.to_sym).book_id, @projectbook.book_id
      assert_equal projectbooks(projectbook.to_sym).project_id, @projectbook.project_id
    }
  end

  def test_deleting_projectbooks
    @projectbooks.each { |projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)
      @projectbook.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectbook.find(projectbooks(projectbook.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectbook = Projectbook.new
    assert !@projectbook.save
  end

  def test_creating_duplicated_projectbook
    @projectbook = Projectbook.new({:project_id => 2, :book_id => 2})
    assert !@projectbook.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectbook.id = 1.6
    assert !@myprojectbook.valid?
    @myprojectbook.id = 'mi_id'
    assert !@myprojectbook.valid?

    @myprojectbook.id = -1
    assert !@myprojectbook.valid?
  end

  def test_bad_values_for_book_id
    @myprojectbook.book_id = nil
    assert !@myprojectbook.valid?

    @myprojectbook.book_id= 1.6
    assert !@myprojectbook.valid?

    @myprojectbook.book_id = 'mi_id'
    assert !@myprojectbook.valid?

    @myprojectbook.book_id = -1
    assert !@myprojectbook.valid?
  end

  def test_bad_values_for_project_id
    @myprojectbook.project_id = nil
    assert !@myprojectbook.valid?

    @myprojectbook.project_id = 3.1416
    assert !@myprojectbook.valid?

    @myprojectbook.project_id = 'mi_id'
    assert !@myprojectbook.valid?

    @myprojectbook.project_id = -1
    assert !@myprojectbook.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectbooks.each { | projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)
      assert_kind_of Projectbook, @projectbook
      assert_equal @projectbook.project_id, Project.find(@projectbook.project_id).id
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
    @projectbooks.each { | projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)
      assert_kind_of Projectbook, @projectbook
      @projectbook.project_id = 1000000
      begin
        return true if @projectbook.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_book_id
    @projectbooks.each { | projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)

      assert_kind_of Projectbook, @projectbook
      assert_equal @projectbook.book_id, Book.find(@projectbook.book_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_book_id
    @projectbooks.each { | projectbook|
      @projectbook = Projectbook.find(projectbooks(projectbook.to_sym).id)
      assert_kind_of Projectbook, @projectbook
      @projectbook.book_id = 100000
      begin
        return true if @projectbook.save
      rescue StandardError => x
        return false
      end
    }
  end

end
