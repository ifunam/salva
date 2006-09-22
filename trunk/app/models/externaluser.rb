class Externaluser < ActiveRecord::Base
validates_presence_of :firstname, :lastname1
validates_numericality_of :institution_id #, :externaluserlevel_id, :degree_id
belongs_to :institution
belongs_to :externaluserlevel
belongs_to :degree
end
