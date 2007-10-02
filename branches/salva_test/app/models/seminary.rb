class Seminary < ActiveRecord::Base
validates_presence_of :title, :year, :institution_id
validates_numericality_of :institution_id
belongs_to :institution
end
