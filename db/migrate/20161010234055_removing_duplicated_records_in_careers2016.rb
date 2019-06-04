class RemovingDuplicatedRecordsInCareers2016 < ActiveRecord::Migration
  def up
    puts "Normalizing names for Careers..."
    Career.all.each do |record|
      normalized_value = record.name.tr("\n",'').tr("\r",'').sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|\.|,|;)+$/, '').sub(/\s{1}+/, ' ')
      normalized_value = 'CareerName' if normalized_value.nil? or normalized_value.empty?
      puts "Normalizing Career name: [ #{[record.id, normalized_value].join(' -> ')} ]"
      record.update_attribute :name, normalized_value.to_s.force_encoding('utf-8')
    end
    cont = 0
    associations = (Career.reflect_on_all_associations(:has_many) + Career.reflect_on_all_associations(:has_one)).collect { |association| association.name }

    #execute "ALTER TABLE institutioncareers DROP CONSTRAINT IF EXISTS institutioncareers_institution_id_key"
    #execute "ALTER TABLE prizes DROP CONSTRAINT IF EXISTS prizes_name_key"
    #execute "ALTER TABLE seminaries DROP CONSTRAINT IF EXISTS seminaries_title_key"
    #execute "ALTER TABLE user_languages DROP CONSTRAINT IF EXISTS user_languages_language_id_key"

    sql = "SELECT UPPER(name) as name FROM careers as i GROUP BY UPPER(name) HAVING ( COUNT(UPPER(name)) > 1)"
    Career.find_by_sql(sql).each do |record|
      puts "== Removing duplicated #{record.name.force_encoding('utf-8')} -> (#{record.id}) in Careers =="
      duplicated_records = Career.find_by_sql("SELECT * FROM careers WHERE UPPER(name) = UPPER('#{record.name.force_encoding('utf-8').gsub(/\'/,'')}') ORDER BY created_on ASC")
      first_record = duplicated_records.shift
      duplicated_records.each do |dup_record|
        associations.each do |association_name|
          puts "Moving records from #{association_name} with career_id #{dup_record.id} to #{first_record.id}"
          execute "UPDATE #{association_name} SET career_id = #{first_record.id} WHERE career_id = #{dup_record.id}"
          cont += 1
        end
        puts "Deleting Career: #{dup_record.id}"
        dup_record.destroy
      end
    end
    # execute "ALTER TABLE institutioncareers ADD CONSTRAINT institutioncareers_institution_id_key UNIQUE (career_id, institution_id)"
    # execute "ALTER TABLE prizes ADD CONSTRAINT prizes_name_key UNIQUE (name, institution_id)"
    # execute "ALTER TABLE seminaries ADD CONSTRAINT seminaries_title_key UNIQUE (title, year, institution_id)"
    # execute "ALTER TABLE user_languages ADD CONSTRAINT user_languages_language_id_key UNIQUE (language_id, institution_id, user_id)" 
    puts associations
    puts "#{cont} records updated"
  end

  def down
  end
end

