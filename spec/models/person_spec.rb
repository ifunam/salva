require 'rails_helper'

describe Person do
  before(:all) do
     @person = Person.new
  end

  [:firstname, :lastname1, :dateofbirth, :country_id].each do |attribute|
    it { should validate_presence_of attribute }
  end

  it { should validate_numericality_of(:country_id).is_greater_than(0).only_integer }

  [:maritalstatus_id, :city_id, :state_id, :user_id].each do |attribute|
    it { should validate_numericality_of(attribute).allow_nil.is_greater_than(0).only_integer }
  end

  it { should validate_inclusion_of(:gender).in_array([true, false]) }

  it { should validate_uniqueness_of :user_id }

  [:maritalstatus, :country, :state, :city, :user].each do |association|
    it { should belong_to(association) }
  end

  it { should have_one :image }

end
