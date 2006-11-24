class Journal < ActiveRecord::Base
validates_presence_of :name, :mediatype_id, :country_id
validates_numericality_of :mediatype_id, :country_id
belongs_to :mediatype
belongs_to :publisher
belongs_to :country
end
