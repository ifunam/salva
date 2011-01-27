class CreateUserRefereedJournals < ActiveRecord::Migration
  def self.up
    create_table :user_refereed_journals do |t|
      t.references :user
      t.references :journal
      t.references :refereed_criterium
      t.text    :refereed_title       # It could be: Articles, letters,
                                      # research_notes, critical scholarly texts,
                                      # invited papers in journals, et. al.
      t.integer :year, :null => false
      t.integer :month
      t.timestamps
    end
  end

  def self.down
    drop_table :user_refereed_journals
  end
end
