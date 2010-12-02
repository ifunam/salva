class RemoveDeprecatedTables < ActiveRecord::Migration
  def self.up
    [ :editions, :externaluserlevels, :externalusers, :tickets,
      :ticketstatuses, :trashes, :usercreditsarticles, :usercreditsbooks,
      :usercreditsconferencetalks, :usercreditsgenericworks, :booksfiles,
      :chapterinbooksfiles, :projectbooks, :projectchapterinbooks, :schema_info ].each do |table|
      if table_exists? table
        execute "DROP TABLE #{table} CASCADE"
      end
    end
  end

  def self.down
  end
end

