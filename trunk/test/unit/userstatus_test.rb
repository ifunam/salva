require File.dirname(__FILE__) + '/../test_helper'

# grab the user model
require 'userstatus'

class UserstatusTest < Test::Unit::TestCase
  fixtures :userstatuses

  # CRUD test

  def test_create
    # create a brand new userstatus
    @userstatus = userstatuses(:example)

    # save him
    assert @userstatus.save
  end  
  
  def test_read
    # read him back
    @userstatus = Userstatus.find(userstatuses(:example).id)
    
    # compare the names
    assert_equal @userstatus.name, userstatuses(:example).name
    
    # compare the ids
    assert_equal @userstatus.id, userstatuses(:example).id
  end
  
  def test_update
    @userstatus = Userstatus.find(userstatuses(:example).id)
    
    # change the name for the user status by using hi-tech encryption ;)
     @userstatus.name = @userstatus.name.reverse
    
    # save the changes
    assert @userstatus.update
  end
  
  def test_delete
    @userstatus = Userstatus.find(userstatuses(:example).id)
    # the userstatus gets killed
    assert @userstatus.destroy
  end
end
