class Review < ActiveRecord::Base
  validates_presence_of :authors, :title, :published_on, :reviewed_work_title, :year
  validates_numericality_of :year, :greater_than => (Date.today.year - 100), :less_than_or_equal_to => (Date.today.year + 1), :only_integer => true
  validates_uniqueness_of :title, :scope => [:user_id, :authors, :title, :year]
end
