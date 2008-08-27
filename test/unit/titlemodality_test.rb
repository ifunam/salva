require File.dirname(__FILE__) + '/../test_helper'

class TitlemodalityTest < ActiveSupport::TestCase
    fixtures :titlemodalities

    should_require_attributes :name
    should_only_allow_numeric_values_for :id
    should_not_allow_values_for :id, -1,  :message => /must be greater than 0/
   should_not_allow_values_for :id, 0,  :message => /must be greater than 0/
    should_not_allow_float_number_for :id
  end
