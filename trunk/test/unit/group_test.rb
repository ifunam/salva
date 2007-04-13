require File.dirname(__FILE__) + '/../test_helper'
require 'group'

class GroupTest < Test::Unit::TestCase
  fixtures :groups
  def setup
    @groups = %w(salva sa geneticos)
  end
  
  # Right - CRUD

  def test_creating_groups_from_yaml
    @groups.each { | group|
      @group = Group.find(groups(group.to_sym).id)
      assert_kind_of Group, @group
      assert_equal groups(group.to_sym).id, @group.id
      assert_equal groups(group.to_sym).name, @group.name
      unless @group.parent_id.nil?
        assert_equal groups(group.to_sym).parent_id, @group.parent_id
      end
    }
  end
  
  def test_update_groups_name
    @groups.each { |group|
      @group = Group.find(groups(group.to_sym).id)
      assert_equal groups(group.to_sym).name, @group.name
      @group.name = @group.name.chars.reverse 
      assert @group.update
      assert_not_equal groups(group.to_sym).name, @group.name
    }
  end

  def test_acts_as_tree
    @group = Group.find(2)
    @group.children.each do |child|
      assert child.parent.id, child.parent_id
    end
  end

  def test_deleting_groups_using_cascade_for_children
    @group = Group.find(groups(:salva).id)
    assert @group.destroy  

    # Destroying :sa and its children
    @group = Group.find(groups(:sa).id)
    assert @group.destroy  

    @groups.each { | group |
      assert_raise(ActiveRecord::RecordNotFound) { 
        Group.find(groups(group.to_sym).id) 
      }
    }
  end   

  def test_creating_group_with_empty_attributes
    @group = Group.new
    assert !@group.save
  end

# Falta reforzar el modelo para que no tenga bugs de integridad
# al usar el acts_as_tree.

#   def test_updating_group_id_for_children
#     @group = Group.find(groups(:sa).id)
#     assert_equal groups(:sa).name, @group.name
#     
#     @group.id = 4
#     assert @group.update
#     
#     @group = Group.find(4)
#     @group.children.each do |child|
#       assert child.parent.id, child.parent_id
#     end
#   end

#   def test_updating_parent_id_with_invalid_parent
#     @group = Group.find(groups(:geneticos).id)
#     @group.parent_id = 10
#     assert @group.update
#   end

   def test_check_uniqueness
     @group = Group.new({:name => 'admin'})
     assert @group.save
    
     @group2 = Group.new({:name => 'admin'  })
     assert !@group2.save
   end
   
   def test_validate_groups_with_bad_values	
     @group = Group.new({:name => 'Departamento', :parent_id => '2'})
     #Non numeric ID 
     @group.id = nil
     assert @group.valid?
     
     #Nil ID 
     @group.name = nil
     assert !@group.valid?
     #Negative number 
     @group.id = -5
     assert !@group.valid?
     
     #Negative number for parent_id
     @group.id= 1.8
     assert !@group.valid?
     @group.parent_id= nil
     assert !@group.valid?
   end   
end
