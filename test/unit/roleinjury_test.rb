require File.dirname(__FILE__) + '/../test_helper'

class RoleinjuryTest < ActiveSupport::TestCase
    fixtures :acadvisittypes

    should_validate_presence_of :name
    should_validate_numericality_of :id
    should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
   should_not_allow_values_for :id, 0,  :message => /must be greater than 0/
    should_not_allow_float_number_for :id
  end
