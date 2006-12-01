class Project < ActiveRecord::Base
validates_presence_of :name, :responsible, :descr, :projecttype_id, :projectstatus_id, :startyear
validates_numericality_of :projecttype_id, :projectstatus_id
belongs_to :projecttype
belongs_to :projectstatus
belongs_to :project
end
