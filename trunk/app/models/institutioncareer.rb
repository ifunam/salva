class Institutioncareer < ActiveRecord::Base
validates_presence_of :career_id, :degree_id, :institution_id
validates_numericality_of :career_id, :degree_id, :institution_id
belongs_to :career
belongs_to :degree
belongs_to :institution
end
