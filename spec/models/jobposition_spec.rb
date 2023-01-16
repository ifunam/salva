require 'rails_helper'

describe Jobposition do
  before(:each) do
    @jobposition = Jobposition.new
  end
  
  it { should validate_presence_of :institution_id }
  it { should validate_presence_of :start_date }
  
  it { should validate_numericality_of(:id).allow_nil.is_greater_than(0).only_integer }
  it { should validate_numericality_of(:institution_id).is_greater_than(0).only_integer}


  it { should validate_numericality_of(:jobpositioncategory_id).allow_nil.is_greater_than(0).only_integer }
  it { should validate_numericality_of(:contracttype_id).allow_nil.is_greater_than(0).only_integer }
  it { should validate_numericality_of(:user_id).allow_nil.is_greater_than(0).only_integer }

  # it { should validate_numericality_of(:startmonth).allow_nil.only_integer } removed, refer to migration RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration
  # it { should validate_numericality_of(:startyear).allow_nil.only_integer } removed, refer to migration RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration
  # it { should validate_numericality_of(:endmonth).allow_nil.only_integer } removed, refer to migration RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration
  # it { should validate_numericality_of(:endyear).allow_nil.only_integer } removed, refer to migration RemoveStartMonthAndStartYearAndEndMonthAndEndYearFromJobpositions < ActiveRecord::Migration

  it { should validate_uniqueness_of(:user_id).scoped_to([:institution_id]) }

  [:jobpositioncategory, :contracttype, :institution, :user].each do |association|
    it { should belong_to association.to_sym }
  end
  
end