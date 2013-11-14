# encoding: utf-8
class UserGenericwork  < ActiveRecord::Base
  attr_accessible :userrole_id, :user_id, :genericwork_id
  validates_presence_of :userrole_id
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :user_id, :userrole_id, :greater_than => 0, :only_integer => true

  belongs_to :genericwork
  belongs_to :userrole
  belongs_to :user

  scope :find_by_year, lambda { |year| joins(:genericwork).where("genericworks.year = ?", year) }

  scope :technical_reports, joins(:genericwork=> :genericworktype).where(:genericwork => {:genericworktype => { :name => 'Reportes técnicos' }})
  scope :popular_science, joins(:genericwork => :genericworktype).where(:genericwork => {:genericworktype => { :genericworkgroup_id => 1 }})
  scope :outreach_works, joins(:genericwork => :genericworktype).where(:genericwork => {:genericworktype => { :genericworkgroup_id => 6 }})
  scope :other_works, joins(:genericwork => :genericworktype).where(:genericwork => {:genericworktype => { :genericworkgroup_id => 5 }})
  scope :teaching_products, joins(:genericwork => :genericworktype).where(:genericwork => {:genericworktype => { :genericworkgroup_id => 4 }})

  def author_with_role
    [user.author_name, "(#{userrole.name})"].join(' ')
  end
end
