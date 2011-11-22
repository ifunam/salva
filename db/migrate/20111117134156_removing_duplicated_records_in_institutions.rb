class RemovingDuplicatedRecordsInInstitutions < ActiveRecord::Migration
  def up

    puts "Normalizing names for Institutions..."
    Institution.all.each do |record|
      normalized_value = record.name.tr("\n",'').tr("\r",'').sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|\.|,|;)+$/, '').sub(/\s{1}+/, ' ')
      normalized_value = 'InstitutionName' if normalized_value.nil? or normalized_value.empty?
      puts "Normalizing Institution name: [ #{[record.id, normalized_value].join(' -> ')} ]"
      record.update_attribute :name, normalized_value.to_s
    end

    associations = Institution.associations_to_move.collect { |association| association.name }

    execute "ALTER TABLE institutioncareers DROP CONSTRAINT institutioncareers_institution_id_key"

    sql = "SELECT UPPER(name) as name FROM institutions as i GROUP BY UPPER(name) HAVING ( COUNT(UPPER(name)) > 1)"
    Institution.find_by_sql(sql).each do |record|
      puts "== Removing duplicated #{record.name} in Institutions =="
      duplicated_records = Institution.find_by_sql("SELECT * FROM institutions WHERE UPPER(name) = UPPER('#{record.name}') ORDER BY created_on ASC")
      first_record = duplicated_records.shift
      duplicated_records.each do |dup_record|
        associations.each do |association_name|
          puts "Moving records from #{association_name} with institution_id #{dup_record.id} to #{first_record.id}"
          execute "UPDATE #{association_name} SET institution_id = #{first_record.id} WHERE institution_id = #{dup_record.id}"
        end
        puts "Deleting Institution: #{dup_record.id}"
        dup_record.destroy
      end
    end

  end

  def down
  end
end
