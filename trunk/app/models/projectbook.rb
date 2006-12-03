class Projectbook < ActiveRecord::Base
validates_presence_of :project_id, :book_id
validates_numericality_of :project_id, :book_id
belongs_to :project
belongs_to :book
end
