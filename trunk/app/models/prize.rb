class Prize < ActiveRecord::Base
validates_presence_of :name, :prizetype_id, :institution_id
validates_numericality_of :prizetype_id, :institution_id
belongs_to :prizetype
belongs_to :institution
end
