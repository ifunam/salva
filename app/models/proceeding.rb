class Proceeding < ActiveRecord::Base
  attr_accessible :title, :year, :volume, :publisher_id, :conference_attributes

  validates_presence_of :title
  validates_numericality_of :id, :publisher_id,  :allow_nil => true, :greater_than =>0, :only_integer => true
  validates_inclusion_of :isrefereed, :in => [true, false]

  belongs_to :conference
  accepts_nested_attributes_for :conference
  belongs_to :publisher
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  has_many :inproceedings

  has_many :user_proceedings
  has_many :users, :through =>  :user_proceedings
  accepts_nested_attributes_for :user_proceedings
  user_association_methods_for :user_proceedings

  has_paper_trail

  default_scope order('title ASC, year DESC')

  scope :user_id_eq, lambda { |user_id| joins(:user_proceedings).where(:user_proceedings => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|
      where("proceedings.id IN (#{UserProceeding.select('DISTINCT(proceeding_id) as proceeding_id').
      where(["user_proceedings.user_id != ?", user_id]).to_sql}) AND proceedings.id  NOT IN (#{UserProceeding.select('DISTINCT(proceeding_id) as proceeding_id').
      where(["user_proceedings.user_id = ?", user_id]).to_sql})")
  }
  search_methods :user_id_eq, :user_id_not_eq

  def as_text
    if title == conference.name
      [title, (publisher.nil? ? nil : publisher.name), year].compact.join(', ')
    else
      [title, (publisher.nil? ? nil : publisher.name), conference.name, year].compact.join(', ')
    end
  end
end
