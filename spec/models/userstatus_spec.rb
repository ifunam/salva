require 'rails_helper'

describe Userstatus do
  before(:all) do
    @userstatus = Userstatus.new
  end
  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
