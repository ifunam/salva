class RemovingDuplicatedRecordsFromPublishers < ActiveRecord::Migration
  def up
    execute "ALTER TABLE publishers DROP CONSTRAINT IF EXISTS publishers_name_key"
    puts "Normalizing names for Publishers..."
    Publisher.all.each do |record|
      normalized_value = record.name.tr("\n",'').tr("\r",'').sub(/^('|"|`|\s)+/, '').sub(/('|"|`|\s|\.|,|;)+$/, '').sub(/\s{1}+/, ' ')
      normalized_value = 'PublisherName' if normalized_value.nil? or normalized_value.empty?
      puts "Normalizing Publisher name: [ #{[record.id, normalized_value].join(' -> ')} ]"
      record.update_attribute :name, normalized_value.to_s
    end

    associations = (Publisher.reflect_on_all_associations(:has_many) + Publisher.reflect_on_all_associations(:has_one)).collect { |association| association.name }

    sql = "SELECT UPPER(name) as name FROM publishers as j GROUP BY UPPER(name) HAVING ( COUNT(UPPER(name)) > 1)"
    Publisher.find_by_sql(sql).each do |record|
      puts "== Removing duplicated #{record.name} in Publishers =="
      duplicated_records = Publisher.find_by_sql("SELECT * FROM publishers WHERE UPPER(name) = UPPER('#{record.name}') ORDER BY created_on ASC")
      first_record = duplicated_records.shift
      duplicated_records.each do |dup_record|
        associations.each do |association_name|
          puts "Moving records from #{association_name} with publisher_id #{dup_record.id} to #{first_record.id}"
          execute "UPDATE #{association_name} SET publisher_id = #{first_record.id} WHERE publisher_id = #{dup_record.id}"
        end
        puts "Deleting Publisher: #{dup_record.id}"
        dup_record.destroy
      end
    end

    execute "ALTER TABLE publishers ADD CONSTRAINT publishers_name_key UNIQUE(name)"
  end

  def down
  end
end
