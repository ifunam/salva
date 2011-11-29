class MoveInstitutionCareerIdInToCareerIdInIndivadvices < ActiveRecord::Migration
  def up
    Indivadvice.where('indivadvicetarget_id <= 3').all.each do |record|
      career_id = record.career_id
      unless career_id.nil?
        record.career_id = career_id
        record.save
        institution_id = record.institution_id
        unless institution_id.nil?
          career = Career.find(record.career_id)
          career.update_attributes(:institution_id => institution_id, :degree_id => record.degree_id)
         end
      else
        if Career.exists?(:degree_id => record.degree_id, :name => 'No definida', :institution_id => record.institution_id)
          career_id = Career.where(:degree_id => record.degree_id, :name => 'No definida', :institution_id => record.institution_id).first.id

        else
          career_id = Career.create!(:degree_id => record.degree_id, :name => 'No definida', :institution_id => record.institution_id).id
        end
        record.update_attribute(:career_id, career_id)
      end
      record.save
    end
  end

  def down
  end
end

