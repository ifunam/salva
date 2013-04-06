class ThesisJuror < ActiveRecord::Base
  @@ignore_meta_date = true
  attr_accessible :roleinjury_id, :user_id, :thesis_id
  validates_presence_of :roleinjury_id
  validates_numericality_of :roleinjury_id
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury

  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

  #RMO set order
  #default_scope order('year DESC, month DESC')

  scope :user_id_not_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where(["thesis_jurors.user_id !=  ?", user_id]) }
  scope :user_id_eq, lambda { |user_id| select('DISTINCT(thesis_id) as thesis_id').where :user_id => user_id }
  scope :since, lambda { |start_date| includes(:thesis).where(:thesis => {:start_date.gteq => start_date}) }
  scope :until, lambda { |end_date| includes(:thesis).where(:thesis => {:end_date.lteq => end_date}) }
  scope :among, lambda { |start_date, end_date|
    joins(:thesis).
    where{
      { :thesis =>
            ({:start_date.gteq => start_date, :end_date.lteq => end_date}) |
            ({:start_date.lteq => start_date, :end_date.lteq => end_date, :end_date.gteq => start_date}) |
            ({:end_date.lteq => end_date, :start_date => nil, :end_date.gteq => start_date}) |
            ({:start_date.gteq => start_date, :end_date.lteq => end_date, :start_date.lt => end_date}) |
            ({:end_date.lteq => end_date, :end_date.gteq => start_date, :start_date.lt => end_date})
      }
    }
  }
  search_methods :among, :splat_param => true, :type => [:date, :date]

  def to_s
    [thesis.authors, thesis.title, user.fullname_or_email, "(#{roleinjury.name})", thesis.date].join(', ')
  end
end
