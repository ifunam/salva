class MoveInstitutionCareerIdToCareerIdInThesisRecords < ActiveRecord::Migration
 def self.up
    if Thesis.count > 0
    Thesis.all.each do |record|
      career_id = record.institutioncareer.career_id
      unless career_id.nil?
        record.career_id = career_id
        record.save
        institution_id = record.institutioncareer.institution_id
        unless institution_id.nil?
          career = Career.find(record.career_id)
          career.update_attribute(:institution_id, institution_id)
        end
      end
      record.save
    end
    end
  end

  def self.down
    Thesis.all.each do |record|
      unless record.career_id.nil?
        record.career.update_attribute(:institution_id, nil)
        record.update_attribute(:career_id, nil)
      end
    end
  end
end
