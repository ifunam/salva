require 'rails_helper'

describe UserGroup do
  before(:all) do
     @user_group = UserGroup.new
  end
  [:id, :user_id].each do |field_name|
    it { should validate_numericality_of(field_name.to_sym).allow_nil.only_integer }
  end
  
  it { should validate_numericality_of(:group_id).is_greater_than(0).only_integer }
  it { should validate_presence_of :group_id }
  it { should validate_uniqueness_of(:group_id).scoped_to([:user_id]) }
  it { should belong_to :user }
  it { should belong_to :group }
end
