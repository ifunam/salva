class RemovingDuplicatedRecordsFromJournals < ActiveRecord::Migration
  def up
    puts "Normalizing names for Journals..."
    Journal.all.each do |record|
      normalized_value = record.name.tr("\n",'').tr("\r",'').sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|\.|,|;)+$/, '').sub(/\s{1}+/, ' ')
      normalized_value = 'JournalName' if normalized_value.nil? or normalized_value.empty?
      puts "Normalizing Journal name: [ #{[record.id, normalized_value].join(' -> ')} ]"
      record.update_attribute :name, normalized_value.to_s
    end

    associations = Journal.associations_to_move.collect { |association| association.name }

    sql = "SELECT name FROM Journals as i GROUP BY name HAVING ( COUNT(name) > 1)"
    Journal.find_by_sql(sql).each do |record|
      puts "== Removing duplicated #{record.name} in Journals =="
      duplicated_records = Journal.where(:name  => record.name).order("created_on ASC").all
      first_record = duplicated_records.shift
      duplicated_records.each do |dup_record|
        associations.each do |association_name|
          puts "Moving records from #{association_name} with journal_id #{dup_record.id} to #{first_record.id}"
          execute "UPDATE #{association_name} SET journal_id = #{first_record.id} WHERE journal_id = #{dup_record.id}"
        end
        puts "Deleting Journal: #{dup_record.id}"
        dup_record.destroy
      end
    end

  end

  def down
  end
end
