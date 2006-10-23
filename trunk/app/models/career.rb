class Career < ActiveRecord::Base
validates_presence_of :name, :degree_id
validates_numericality_of :degree_id
belongs_to :degree
end
