class MoveUniversityAndCountryIdsIntoOtherModels < ActiveRecord::Migration
  def self.up
    cont = 0

    #Lista con los modelos para actualizar sus columnas de university_id country_id
    models = [Career,Indivadvice]
    #Career #No sé si es necesario
    models.each do |model|
      model.all(:order => 'id ASC').each do |record|
        puts "Migrating #{model} ID: #{record.id}"
        model_id = record.id
        unless model_id.nil?
          institution_id = record.institution_id
          unless institution_id.nil?
            institution = Institution.find(institution_id)
            unless model==Career
              unless record.career.nil?
                puts "Setting University ID (#{institution.institution_id}) Country ID (#{institution.country_id}) and Degree ID (#{record.career.degree_id}) in #{model} record (#{model_id})"
                record.update_attribute(:degree_id, record.career.degree_id)
              end
            else
              puts "Setting University ID (#{institution.institution_id}) and Country ID (#{institution.country_id}) in #{model} record (#{model_id})" 
            end
            record.update_attribute(:university_id, institution.institution_id)
            record.update_attribute(:country_id, institution.country_id)
            cont += 1
          end
        end
      end
    end
    #Lista con los modelos para actualizar sus columnas de institution_id university_id country_id degree_id
    models = [Academicprogram,Thesis,TutorialCommittee,Education]
    models.each do |model|
      model.all(:order => 'id ASC').each do |record|
        puts "Migrating #{model} ID: #{record.id}"
        model_id = record.id
        unless model_id.nil?
          unless record.career_id.nil?
            institution_id = record.career.institution_id
            unless institution_id.nil?
              institution = Institution.find(institution_id)
              puts "Setting Institution ID (#{institution_id}) University ID (#{institution.institution_id}) Country ID (#{institution.country_id}) and Degree ID (#{record.career.degree_id}) in #{model} record (#{model_id})"
              record.update_attribute(:institution_id, institution_id)
              record.update_attribute(:university_id, institution.institution_id)
              record.update_attribute(:country_id, institution.country_id)
              record.update_attribute(:degree_id, record.career.degree_id)
              cont += 1
            end
          end
        end
      end
    end
    puts "#{cont} records updated"
  end

  def self.down
  end
end

