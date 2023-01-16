require 'spec_helper'

describe Person do
  before(:all) do
     @person = Person.make!
  end

  [:firstname, :lastname1, :dateofbirth, :country_id].each do |attribute|
    it { should validate_presence_of attribute }
  end

  it { should validate_numericality_of :country_id, :greater_than => 0, :only_integer => true}

  [:maritalstatus_id, :city_id, :state_id, :user_id].each do |attribute|
    it { should validate_numericality_of attribute, :allow_nil => true, :greater_than => 0, :only_integer => true }
  end

  it { should validate_inclusion_of :gender, :in => [true, false] }

  it { should validate_uniqueness_of :user_id }

  [:maritalstatus, :country, :state, :city, :user].each do |association|
    it { should belong_to(association) }
  end

  it { should have_one :image }

end
