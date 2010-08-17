require 'spec_helper'

describe UserGroup do
  before(:all) do
     @user_group = UserGroup.make!
  end
  [:id, :user_id].each do |field_name|
    it { should validate_numericality_of field_name.to_sym, :user_id, :allow_nil => true, :only_integer => true }
  end
  
  it { should validate_numericality_of :group_id, :greater_than => 0, :only_integer => true }
  it { should validate_presence_of :group_id }
  it { should validate_uniqueness_of :group_id, :scope => [:user_id] }
  it { should belong_to :user }
  it { should belong_to :group }
end
