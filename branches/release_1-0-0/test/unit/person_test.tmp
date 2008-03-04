require File.dirname(__FILE__) + '/../test_helper'
require RAILS_ROOT + '/lib/digest'
class UserTest < Test::Unit::TestCase
  fixtures :users, :people, :maritalstatuses, :countrys, :states, :cities
  include Digest

  def setup
    @default_users = %w( admin juana panchito )
  end
end
