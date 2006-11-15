class Article < ActiveRecord::Base
validates_presence_of :title, :journal_id, :articlestatus_id, :year
validates_numericality_of :journal_id, :articlestatus_id
belongs_to :journal
belongs_to :articlestatus
end
