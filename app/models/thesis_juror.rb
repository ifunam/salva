class ThesisJuror < ActiveRecord::Base
  @@ignore_meta_date = true
  # attr_accessor :roleinjury_id, :user_id, :thesis_id, :year, :month
  validates_presence_of :roleinjury_id
  validates_numericality_of :roleinjury_id
  belongs_to :user
  belongs_to :thesis
  belongs_to :roleinjury

  belongs_to :registered_by, :class_name => 'User', :foreign_key => 'registered_by_id'
  belongs_to :modified_by, :class_name => 'User', :foreign_key => 'modified_by_id'

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
  scope :thesismodality_id_eq, lambda { |id| joins(:thesis).where("theses.thesismodality_id = ?", id).order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC") }
  scope :authors_cont, lambda { |a| joins(:thesis).where("theses.authors ILIKE ?", "%#{a}%").order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC") }
  scope :since_date, lambda { |d| joins(:thesis).where("theses.end_date >= ?", d).order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC") }
  scope :until_date, lambda { |d| joins(:thesis).where("theses.end_date <= ?", d).order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC") }
  scope :degree_id_eq, lambda { |id| joins(:thesis).where({:thesis => { :degree_id=> id}}).order("theses.end_date DESC, theses.start_date DESC, theses.authors ASC, theses.title ASC") }

  # search_methods :among, :splat_param => true, :type => [:date, :date]
  # search_methods :thesismodality_id_eq, :authors_cont, :since_date, :until_date,
                 :degree_id_eq

  def to_s
    [thesis.authors, thesis.title, user.fullname_or_email, "(#{roleinjury.name})", thesis.date].join(', ')
  end
end
