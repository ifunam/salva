class Inproceeding < ActiveRecord::Base
  # attr_accessor  :authors, :title, :pages, :proceeding_attributes, :user_inproceedings_attributes
  validates_presence_of :title, :authors
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true

  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  belongs_to :proceeding
  accepts_nested_attributes_for :proceeding

  has_many :user_inproceedings
  has_many :users, :through =>  :user_inproceedings
  accepts_nested_attributes_for :user_inproceedings
  user_association_methods_for :user_inproceedings

  has_paper_trail

  default_scope -> { order(inproceedings: {authors: :asc, title: :asc }) }

  scope :ordered_by_year, order("proceedings.year DESC, inproceedings.authors  ASC, inproceedings.title ASC")
  scope :refereed, -> { joins("INNER JOIN proceedings ON proceedings.isrefereed = 't' AND inproceedings.proceeding_id = proceedings.id").ordered_by_year }
  scope :unrefereed, -> { joins("INNER JOIN proceedings ON proceedings.isrefereed = 'f' AND inproceedings.proceeding_id = proceedings.id").ordered_by_year }

  scope :user_id_eq, lambda { |user_id| joins(:user_inproceedings).where(:user_inproceedings => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|
      inproceeding_without_user_sql = UserInproceeding.select('DISTINCT(inproceeding_id) as inproceeding_id').where(["user_inproceedings.user_id != ?", user_id]).to_sql
      inproceeding_with_user_sql = UserInproceeding.select('DISTINCT(inproceeding_id) as inproceeding_id').where(["user_inproceedings.user_id = ?", user_id]).to_sql
      sql = "inproceedings.id IN (#{inproceeding_without_user_sql}) AND inproceedings.id NOT IN (#{inproceeding_with_user_sql})"
      where sql
  }

  scope :since, lambda { |year| includes(:proceeding).where(["proceedings.year >= ?", year])}
  scope :until, lambda { |year| includes(:proceeding).where(["proceedings.year <= ?", year])}
  scope :year_eq, lambda { |year| includes(:proceeding).where('proceedings.year = ?', year) }
  scope :among, lambda { |start_year, end_year| includes(:proceeding).where(["proceedings.year = ?", start_year])}
  # search_methods :user_id_eq, :user_id_not_eq, :year_eq
  # search_methods :among, :splat_param => true, :type => [:integer, :integer]

  # search_methods :user_id_eq, :user_id_not_eq

  def to_s
    ["#{authors}\n", "\"#{title}\"; "].join(' ') +  [proceeding.to_s, pages].compact.join(', ')
  end
end
