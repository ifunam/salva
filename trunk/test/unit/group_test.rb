require File.dirname(__FILE__) + '/../test_helper'
require 'group'
class GroupTest < Test::Unit::TestCase
  fixtures :groups
  # CRUD test
  def test_create
    # create a brand new group
    @group = groups(:example)

    # save him
    assert @group.save
  end  
  
  def test_read
    # read him back
    @group = Group.find(groups(:example).id)
    
    # compare the names
    assert_equal @group.name, groups(:example).name
    
    # compare the ids
    assert_equal @group.id, groups(:example).id
  end
  
  def test_update
    @group = Group.find(groups(:example).id)
    
    # change the name for the user status by using hi-tech encryption ;)
     @group.name = @group.name.reverse
    
    # save the changes
    assert @group.update
  end
  
  def test_delete
    @group = Group.find(groups(:example).id)
    # the group gets killed
    assert @group.destroy
  end
end
