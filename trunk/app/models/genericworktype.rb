class Genericworktype < ActiveRecord::Base
validates_presence_of :name, :genericworkgroup_id
validates_numericality_of :genericworkgroup_id
belongs_to :genericworkgroup
end
