class ExtractPhotosFromPeopleToFileSystem < ActiveRecord::Migration
  def self.up
    base_path = Rails.root.to_s + '/tmp'
    Person.where("photo IS NOT NULL AND photo_content_type IS NOT NULL").all.each do |record|
      user_path = File.join(base_path, 'image/file', record.id.to_s)
      unless File.exist? user_path
        puts "Creating directory: #{user_path}"
        system "mkdir -p #{user_path}"
      end
      original_photo = File.join(user_path, "#{record.user.login}.#{record.photo_content_type}")
      puts "Creating file: #{original_photo}"

      File.open(original_photo, 'w') do |f|
        f.write record.photo.force_encoding('utf-8')
      end

      puts "Uploading file: #{original_photo}"
      record.image = Image.new(:file => File.open(original_photo))
      record.save

      puts "Deleting file: #{original_photo}"
      File.delete original_photo
    end
  end

  def self.down
  end
end
