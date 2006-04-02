class Institutioncareer < ActiveRecord::Base

#validates_presence_of , :degree_id, :institution_id, :career_id, degree, institution, career, :degree_id, :institution_id, :career_id
validates_numericality_of :degree_id, :institution_id, :career_id
belongs_to :degree
belongs_to :institution
belongs_to :career

end

