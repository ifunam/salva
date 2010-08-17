require 'spec_helper'

describe UserAdscription do
  before(:each) do
    @user_adscription = UserAdscription.make!
  end
  it { should validate_presence_of :adscription_id }
  it { should validate_presence_of :start_date }

  [:id, :jobposition_id, :user_id, :startyear].each do |field_name|
    it { should validate_numericality_of field_name.to_sym, :allow_nil => true, :greater_than =>0, :only_integer => true }
  end
  
  it { should validate_numericality_of :adscription_id, :greater_than => 0, :only_integer => true }
  it { should validate_inclusion_of :startmonth, :in => 1..12, :allow_nil => true }
  it { should validate_inclusion_of :endmonth, :in => 1..12, :allow_nil => true }

  it { should belong_to :user }
  it { should belong_to :adscription }
end