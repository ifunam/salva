require File.dirname(__FILE__) + '/../test_helper'
require 'project'
require 'article'
require 'projectarticle'

class ProjectarticleTest < Test::Unit::TestCase
  fixtures :projecttypes,:projectstatuses, :projects,  :countries, :mediatypes, :publishers, :journals, :articlestatuses,:articles, :projectarticles

  def setup
    @projectarticles = %w(el_radiotelescopio_de_centelleo_interplanetario los_barrancos_en_marte)
    @myprojectarticle = Projectarticle.new({:project_id => 1, :article_id => 1})
  end

  # Right - CRUD
  def test_creating_projectarticles_from_yaml
    @projectarticles.each { | projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      assert_kind_of Projectarticle, @projectarticle
      assert_equal projectarticles(projectarticle.to_sym).id, @projectarticle.id
      assert_equal projectarticles(projectarticle.to_sym).article_id, @projectarticle.article_id
      assert_equal projectarticles(projectarticle.to_sym).project_id, @projectarticle.project_id
    }
  end

  def test_deleting_projectarticles
    @projectarticles.each { |projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      @projectarticle.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @projectarticle = Projectarticle.new
    assert !@projectarticle.save
  end

  def test_creating_duplicated_projectarticle
    @projectarticle = Projectarticle.new({:project_id => 3, :article_id => 2})
    assert !@projectarticle.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @myprojectarticle.id = 1.6
    assert !@myprojectarticle.valid?
    @myprojectarticle.id = 'mi_id'
    assert !@myprojectarticle.valid?
  end

  def test_bad_values_for_article_id
    @myprojectarticle.article_id = nil
    assert !@myprojectarticle.valid?

    @myprojectarticle.article_id= 1.6
    assert !@myprojectarticle.valid?

    @myprojectarticle.article_id = 'mi_id'
    assert !@myprojectarticle.valid?
  end

  def test_bad_values_for_project_id
    @myprojectarticle.project_id = nil
    assert !@myprojectarticle.valid?

    @myprojectarticle.project_id = 3.1416
    assert !@myprojectarticle.valid?
    @myprojectarticle.project_id = 'mi_id'
    assert !@myprojectarticle.valid?
  end

  #Cross-Checking test
  def test_cross_checking_for_project_id
    @projectarticles.each { | projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      assert_kind_of Projectarticle, @projectarticle
      assert_equal @projectarticle.project_id, Project.find(@projectarticle.project_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_project_id
    @projectarticles.each { | projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      assert_kind_of Projectarticle, @projectarticle
      @projectarticle.project_id = 1000000
      begin
        return true if @projectarticle.update
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_article_id
    @projectarticles.each { | projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)

      assert_kind_of Projectarticle, @projectarticle
      assert_equal @projectarticle.article_id, Article.find(@projectarticle.article_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.update
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_article_id
    @projectarticles.each { | projectarticle|
      @projectarticle = Projectarticle.find(projectarticles(projectarticle.to_sym).id)
      assert_kind_of Projectarticle, @projectarticle
      @projectarticle.article_id = 100000
      begin
        return true if @projectarticle.update
      rescue StandardError => x
        return false
      end
    }
  end

end