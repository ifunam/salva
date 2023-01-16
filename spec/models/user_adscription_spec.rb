require 'rails_helper'

describe UserAdscription do
  before(:each) do
    @user_adscription = UserAdscription.new
  end
  it { should validate_presence_of :adscription_id }
  it { should validate_presence_of :start_date }

  [:id, :jobposition_id, :user_id, :startyear].each do |field_name|
    it { should validate_numericality_of(field_name.to_sym).allow_nil.is_greater_than(0).only_integer }
  end
  
  it { should validate_numericality_of(:adscription_id).is_greater_than(0).only_integer }
  it { should validate_inclusion_of(:startmonth).in_range(1..12).allow_nil  }
  it { should validate_inclusion_of(:endmonth).in_range(1..12).allow_nil }

  it { should belong_to :user }
  it { should belong_to :adscription }
end