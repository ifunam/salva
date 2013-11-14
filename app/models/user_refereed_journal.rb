# encoding: utf-8
require Rails.root.to_s + '/lib/salva/meta_date_extension'
class UserRefereedJournal < ActiveRecord::Base
  include MetaDateExtension::DateMethods
  attr_accessible :journal_id, :refereed_criterium_id, :year, :month

  validates_presence_of :year
  belongs_to :user, :inverse_of => :user_refereed_journals
  belongs_to :registered_by, :class_name => 'User', :foreign_key => :registered_by_id
  belongs_to :modified_by, :class_name => 'User', :foreign_key => :modified_by_id
  belongs_to :journal, :inverse_of => :user_refereed_journals
  belongs_to :refereed_criterium

  def to_s
    s = []
    s.push "Árbitro de #{refereed_criterium.name}" unless refereed_criterium_id.nil?
    s.push journal.name unless journal_id.nil?
    s.push date
    s.compact.join(', ')
  end
end
