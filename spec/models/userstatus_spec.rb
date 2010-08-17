require 'spec_helper'

describe Userstatus do
  before(:all) do
    @userstatus = Userstatus.make!
  end
  should_validate_presence_of :name
  should_validate_uniqueness_of :name
end
