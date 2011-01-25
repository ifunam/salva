class MoveInstitutionCareerIdInToCareerIdInAcademicProgramRecords < ActiveRecord::Migration
  def self.up
    Academicprogram.all.each do |record|
      unless record.institutioncareer.nil?
        puts "Migrating Academicprogram ID: #{record.id}"
        career_id = record.institutioncareer.career_id
        unless career_id.nil?
          puts "Setting Career ID (#{career_id}) in Academicprogram record (#{record.id})"
          record.update_attribute(:career_id, career_id)
          institution_id = record.institutioncareer.institution_id
          unless institution_id.nil?
            puts "Setting Institution ID (#{institution_id}) in Career record (#{career_id})"
            career = Career.find(career_id)
            career.update_attribute(:institution_id, institution_id)
          end
        end
      end
    end
  end

  def self.down
  end
end
