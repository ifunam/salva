class Course < ActiveRecord::Base
validates_presence_of :title, :coursetype_id
validates_numericality_of :coursetype_id, :degree_id
belongs_to :coursetype
belongs_to :degree
end
