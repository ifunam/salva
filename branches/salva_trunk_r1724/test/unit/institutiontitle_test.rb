require File.dirname(__FILE__) + '/../test_helper'
require 'institutiontitle'

class InstitutiontitleTest < Test::Unit::TestCase
  fixtures :institutiontitles
  include UnitSimple

  def setup
    @institutiontitles = %w(escuela facultad)
    @myinstitutiontitle = Institutiontitle.new({:name => 'Otra'})
  end

  # Right - CRUD

  def test_crud
     crud_test(@institutiontitles,Institutiontitle)
   end

   def test_validation
     validate_test(@institutiontitles, Institutiontitle)
   end

   def test_collision
     collision_test(@institutiontitles, Institutiontitle)
   end

   def test_uniqueness
    @institutiontitle = Institutiontitle.new({:name => 'Escuela'})
    assert !@institutiontitle.save
  end

  def test_empty_object
    @institutiontitle = Institutiontitle.new()
    assert !@institutiontitle.save
  end

   # Boundaries
   def test_bad_values_for_id
    @myinstitutiontitle.id = 'xx'
    assert !@myinstitutiontitle.valid?

     # Float number ID
    @myinstitutiontitle.id = 1.3
     assert !@myinstitutiontitle.valid?
   end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myinstitutiontitle.name = nil
    assert !@myinstitutiontitle.valid?
  end
end
