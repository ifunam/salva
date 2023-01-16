require 'spec_helper'

describe Userstatus do
  before(:all) do
    @userstatus = Userstatus.make!
  end
  should validate_presence_of :name
  should validate_uniqueness_of :name
end
