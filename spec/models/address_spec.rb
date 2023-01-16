require 'rails_helper'

describe Address do
  before(:all) do 
    @address = Address.new
  end
  [:country_id, :location, :addresstype_id].each do |attribute|
    it { should validate_presence_of attribute }
  end
  
  [:id, :state_id, :city_id, :user_id].each do |attribute|
    it { should validate_numericality_of(attribute).allow_nil.only_integer.is_greater_than(0) }
  end


  [ :addresstype_id, :country_id].each do |attribute|
     it { should validate_numericality_of(attribute).is_greater_than(0).only_integer }
  end
  
  it { should validate_inclusion_of(:is_postaddress).in_array([true, false]) }
  it { should validate_uniqueness_of(:addresstype_id).scoped_to([:user_id]) }
  
  [:country, :addresstype, :city, :state, :user].each do |association|
   it { should belong_to association }
  end
end
