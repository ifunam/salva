class Projectchapterinbook < ActiveRecord::Base
validates_presence_of :project_id, :chapterinbook_id
validates_numericality_of :project_id, :chapterinbook_id
belongs_to :project
belongs_to :chapterinbook
end
