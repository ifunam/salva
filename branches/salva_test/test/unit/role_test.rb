 require File.dirname(__FILE__) + '/../test_helper'
 require 'role'

 class RoleTest < Test::Unit::TestCase
   fixtures :roles

   def setup
     @roles = %w(administrador salva)
     @myrole = Role.new({:name => 'Otro', :has_group_right => true })
   end

   # Right - CRUD
   def test_creating_roles_from_yaml
     @roles.each { | role|
       @role = Role.find(roles(role.to_sym).id)
       assert_kind_of Role, @role
       assert_equal roles(role.to_sym).id, @role.id
       assert_equal roles(role.to_sym).name, @role.name
     }
   end

   def test_updating_roles_name
     @roles.each { |role|
       @role = Role.find(roles(role.to_sym).id)
       assert_equal roles(role.to_sym).name, @role.name
       @role.update_attribute('name', @role.name.chars.reverse)
       assert_not_equal roles(role.to_sym).name, @role.name
     }
   end

   def test_deleting_roles
     @roles.each { |role|
       @role = Role.find(roles(role.to_sym).id)
       @role.destroy
       assert_raise (ActiveRecord::RecordNotFound) {
         Role.find(roles(role.to_sym).id)
       }
     }
   end

   def test_creating_with_empty_attributes
     @role = Role.new
     assert !@role.save
   end

   #def test_creating_duplicated_role
   # @role = Role.new({:name => 'Admnistrador', :has_group_right => true })
   #assert !@role.save
   #end

   # Boundary
   def test_bad_values_for_id
     # Float number for ID
     @myrole.id = 1.6
     assert !@myrole.valid?
     @myrole.id = 'mi_id'
     assert !@myrole.valid?
     @myrole.id = -1
     assert !@myrole.valid?
   end

   def test_bad_values_for_name
     # Float number for ID
     @myrole.name = nil
     assert !@myrole.valid?
   end

 end
