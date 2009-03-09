class Chapterinbook < ActiveRecord::Base
  validates_presence_of :bookchaptertype_id, :title
  validates_numericality_of :id, :allow_nil => true, :greater_than => 0, :only_integer => true
  validates_numericality_of :bookchaptertype_id, :greater_than => 0, :only_integer => true

  #validates_uniqueness_of :title, :scope => [:bookedition_id, :bookchaptertype_id]

  belongs_to :bookedition
  belongs_to :bookchaptertype

  has_many :projectchapterinbooks
  has_many :chapterinbook_comments

  #validates_associated :bookedition
  #validates_associated :bookchaptertype
  named_scope :recent, :order => 'bookeditions.year DESC, bookeditions.month DESC', :include => :bookedition, :limit => 20
  named_scope :published, :conditions => 'bookeditions.editionstatus_id = 1', :include => :bookedition
  named_scope :inprogress, :conditions => 'bookeditions.editionstatus_id != 1', :include => :bookedition
  
  def as_text
      editionstatus_name = bookedition.editionstatus.nil? ? nil :  bookedition.editionstatus.name
      as_text_line([bookedition.book.authors, bookedition.book.title, label_for(title, bookchaptertype.name), label_for(bookedition.edition, 'Edición'),
                    label_for(bookedition.isbn, 'ISBN'), pages, bookedition.year, bookedition.month, bookedition.book.country.name, 
                    label_for(bookedition.book.booktype.name,'Tipo de libro'), label_for(editionstatus_name, 'Estado')])
  end
end
