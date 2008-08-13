require File.dirname(__FILE__) + '/../test_helper'
require 'institution'
require 'user'
require 'membership'

class MembershipTest < Test::Unit::TestCase
  fixtures :countries, :states, :cities, :institutiontitles, :institutiontypes, :institutions, :userstatuses, :users, :memberships

  def setup
    @memberships = %w(juana_unam panchito_sep)
    @mymembership = Membership.new({:user_id => 1, :institution_id => 1})
  end

  # Right - CRUD
  def test_creating_memberships_from_yaml
    @memberships.each { | membership|
      @membership = Membership.find(memberships(membership.to_sym).id)
      assert_kind_of Membership, @membership
      assert_equal memberships(membership.to_sym).id, @membership.id
      assert_equal memberships(membership.to_sym).institution_id, @membership.institution_id
      assert_equal memberships(membership.to_sym).user_id, @membership.user_id
    }
  end

  def test_deleting_memberships
    @memberships.each { |membership|
      @membership = Membership.find(memberships(membership.to_sym).id)
      @membership.destroy
      assert_raise (ActiveRecord::RecordNotFound) {
        Membership.find(memberships(membership.to_sym).id)
      }
    }
  end

  def test_creating_with_empty_attributes
    @membership = Membership.new
    assert !@membership.save
  end

  # Boundary
  def test_bad_values_for_id
    # Float number for ID
    @mymembership.id = 1.6
    assert !@mymembership.valid?
    @mymembership.id = 'mi_id'
    assert !@mymembership.valid?
  end

  def test_bad_values_for_institution_id
    @mymembership.institution_id = nil
    assert !@mymembership.valid?

    @mymembership.institution_id= 1.6
    assert !@mymembership.valid?

    @mymembership.institution_id = 'mi_id'
    assert !@mymembership.valid?
  end

  def test_bad_values_for_user_id
    @mymembership.user_id = nil
    assert !@mymembership.valid?

    @mymembership.user_id = 3.1416
    assert !@mymembership.valid?
    @mymembership.user_id = 'mi_id'
    assert !@mymembership.valid?
  end
  #Cross-Checking test

  def test_cross_checking_for_user_id
    @memberships.each { | membership|
      @membership = Membership.find(memberships(membership.to_sym).id)
      assert_kind_of Membership, @membership
      assert_equal @membership.user_id, User.find(@membership.user_id).id
    }
  end


  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_user_id
    @memberships.each { | membership|
      @membership = Membership.find(memberships(membership.to_sym).id)
      assert_kind_of Membership, @membership
      @membership.user_id = 10
      begin
        return true if @membership.save
      rescue StandardError => x
        return false
      end
    }
  end

  def test_cross_checking_for_institution_id
    @memberships.each { | membership|
      @membership = Membership.find(memberships(membership.to_sym).id)

      assert_kind_of Membership, @membership
      assert_equal @membership.institution_id, Institution.find(@membership.institution_id).id
    }
  end

  def catch_exception_when_update_invalid_key(record)
    begin
      return true if record.save
    rescue ActiveRecord::StatementInvalid => bang
      return false
    end
  end

  def test_cross_checking_with_bad_values_for_institution_id
    @memberships.each { | membership|
      @membership = Membership.find(memberships(membership.to_sym).id)
      assert_kind_of Membership, @membership
      @membership.institution_id = 100000
      begin
        return true if @membership.save
      rescue StandardError => x
        return false
      end
    }
  end

end
