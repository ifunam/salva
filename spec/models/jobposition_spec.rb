require 'spec_helper'

describe Jobposition do
  before(:each) do
    @jobposition = Jobposition.make!
  end
  
  it { should validate_presence_of :institution_id }
  it { should validate_presence_of :start_date }
  
  it { should validate_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true }
  it { should validate_numericality_of :institution_id, :greater_than => 0, :only_integer => true}


  it { should validate_numericality_of :jobpositioncategory_id, :allow_nil => true, :greater_than => 0, :only_integer => true }
  it { should validate_numericality_of :contracttype_id, :allow_nil => true, :greater_than => 0, :only_integer => true }
  it { should validate_numericality_of :user_id, :allow_nil => true, :greater_than => 0, :only_integer => true }

  it { should validate_numericality_of :startmonth, :allow_nil => true, :only_integer => true }
  it { should validate_numericality_of :startyear, :allow_nil => true, :only_integer => true}
  it { should validate_numericality_of :endmonth, :allow_nil => true, :only_integer => true }
  it { should validate_numericality_of :endyear, :allow_nil => true, :only_integer => true }

  it { should validate_uniqueness_of :user_id, :scope => [:institution_id, :startyear] }

  [:jobpositioncategory, :contracttype, :institution, :user].each do |association|
    it { should belong_to association.to_sym }
  end
  
end