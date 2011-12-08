class Inproceeding < ActiveRecord::Base
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

  default_scope order("authors ASC, title ASC")
  scope :refereed, joins("INNER JOIN proceedings ON proceedings.isrefereed = 't' AND inproceedings.proceeding_id = proceedings.id")
  scope :unrefereed, joins("INNER JOIN proceedings ON proceedings.isrefereed = 'f' AND inproceedings.proceeding_id = proceedings.id")

  scope :user_id_eq, lambda { |user_id| joins(:user_inproceedings).where(:user_inproceedings => {:user_id => user_id}) }
  scope :user_id_not_eq, lambda { |user_id|
      where("inproceedings.id IN (#{UserInproceeding.select('DISTINCT(inproceeding_id) as inproceeding_id').
      where(["user_inproceedings.user_id != ?", user_id]).to_sql}) AND inproceedings.id  NOT IN (#{UserInproceeding.select('DISTINCT(inproceeding_id) as inproceeding_id').
      where(["user_inproceedings.user_id = ?", user_id]).to_sql})")
  }

  search_methods :user_id_eq, :user_id_not_eq

  def as_text
    ["#{authors}\n", "\"#{title}\"; "].join(' ') +  [proceeding.as_text, pages].compact.join(', ')
  end
end
