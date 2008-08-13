require File.dirname(__FILE__) + '/../test_helper'
require 'institutiontype'

class InstitutiontypeTest < Test::Unit::TestCase
  fixtures :institutiontypes
  include UnitSimple

  def setup
    @institutiontypes = %w(publica privada)
    @myinstitutiontype = Institutiontype.new({:name => 'Otra'})
  end

  # Right - CRUD

  def test_crud
     crud_test(@institutiontypes,Institutiontype)
   end

   def test_validation
     validate_test(@institutiontypes, Institutiontype)
   end

   def test_collision
     collision_test(@institutiontypes, Institutiontype)
   end

   def test_uniqueness
    @institutiontype = Institutiontype.new({:name => 'Privada'})
    assert !@institutiontype.save
  end

  def test_empty_object
    @institutiontype = Institutiontype.new()
    assert !@institutiontype.save
  end

   # Boundaries
   def test_bad_values_for_id
    @myinstitutiontype.id = 'xx'
    assert !@myinstitutiontype.valid?

     # Float number ID
    @myinstitutiontype.id = 1.3
     assert !@myinstitutiontype.valid?
   end

  def test_bad_values_for_name
    # Checking constraints for name
    # Nil name
    @myinstitutiontype.name = nil
    assert !@myinstitutiontype.valid?
  end
end
