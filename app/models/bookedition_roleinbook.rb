class BookeditionRoleinbook < ActiveRecord::Base
  # attr_accessor :user_id, :roleinbook_id, :bookedition_id
  validates :roleinbook_id, :presence => true

  belongs_to :bookedition
  belongs_to :roleinbook
  belongs_to :user
  belongs_to :registered_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'

  scope :published, -> { where(bookeditions: { editionstatus_id: 1 }) }
  scope :authors, -> { where("roleinbook_id = 1 OR roleinbook_id = 2") }
  scope :collaborators, -> { where("roleinbook_id != 1 AND roleinbook_id != 2") }
  scope :find_by_year, lambda { |year| joins(:bookedition).where('bookeditions.year = ?', year) }
  scope :adscription_id, lambda { |id| joins(:user => :user_adscription).where(:user => { :user_adscription => { :adscription_id => id} }) }

  # # search_methods :find_by_year, :adscription_id

  def to_s
    "#{user.author_name} (#{roleinbook.name})"
  end
end
