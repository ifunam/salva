# encoding: utf-8
require Rails.root.to_s + '/lib/salva/meta_date_extension'
class UserRefereedJournal < ActiveRecord::Base
  include Salva::MetaDateExtension::DateMethods
  # attr_accessor :journal_id, :refereed_criterium_id, :year, :month

  validates_presence_of :year
  belongs_to :user, :inverse_of => :user_refereed_journals
  belongs_to :registered_by, :class_name => 'User', :foreign_key => :registered_by_id
  belongs_to :modified_by, :class_name => 'User', :foreign_key => :modified_by_id
  belongs_to :journal, :inverse_of => :user_refereed_journals
  belongs_to :refereed_criterium

  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # search_methods :adscription_id

  def to_s
    s = []
    s.push "Árbitro de #{refereed_criterium.name}" unless refereed_criterium_id.nil?
    s.push(journal_name)
    s.push date
    s.compact.join(', ')
  end

  def journal_name
    (journal_id.nil? or journal.nil?) ? '-' : journal.name
  end

  def journal_country
    (journal_id.nil? or journal.nil?) ? '-' : journal.country_name
  end

  def refereed_criterium_name
    refereed_criterium_id.nil? ? '-' : refereed_criterium.name
  end
end
