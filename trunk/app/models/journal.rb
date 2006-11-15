class Journal < ActiveRecord::Base
validates_presence_of :name, :journaltype_id, :mediatype_id, :publisher_id, :country_id
validates_numericality_of :journaltype_id, :mediatype_id, :publisher_id, :country_id
belongs_to :journaltype
belongs_to :mediatype
belongs_to :publisher
belongs_to :country
end
