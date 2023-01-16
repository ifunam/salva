require 'spec_helper'

describe Address do
  before(:all) do 
    @address = Address.make!
  end
  [:country_id, :location, :addresstype_id].each do |attribute|
    it { should validate_presence_of attribute }
  end
  
  [:id, :state_id, :city_id, :user_id].each do |attribute|
    it { should validate_numericality_of attribute, :allow_nil => true, :greater_than => 0, :only_integer => true }
  end


  [ :addresstype_id, :country_id].each do |attribute|
     it { should validate_numericality_of attribute, :greater_than => 0, :only_integer => true }
  end
  
  it { should validate_inclusion_of :is_postaddress, :in=> [true, false] }
  it { should validate_uniqueness_of :addresstype_id, :scope => [:user_id] }
  
  [:country, :addresstype, :city, :state, :user].each do |association|
   it { should belong_to association }
  end
end
