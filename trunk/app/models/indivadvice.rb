class Indivadvice < ActiveRecord::Base
validates_presence_of :indivadvicetarget_id, :year, :hours
validates_numericality_of :institution_id, :indivadvicetarget_id, :degree_id
belongs_to :indivuser
belongs_to :institution
belongs_to :indivadvicetarget
belongs_to :indivadviceprogram
belongs_to :degree
end
