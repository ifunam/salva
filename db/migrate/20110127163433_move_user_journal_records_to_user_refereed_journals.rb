class MoveUserJournalRecordsToUserRefereedJournals < ActiveRecord::Migration
  def self.up
    UserJournal.where(:roleinjournal_id => 4).all.each do |record|
      @refereed_journal = UserRefereedJournal.create(:journal_id => record.journal_id,
                                                     :refereed_criterium_id => 1, :user_id => record.user_id,
                                                     :year => record.startyear, :month => record.startmonth)
      if @refereed_journal.valid?
        record.destroy
      end
    end
  end

  def self.down
    UserRefereedJournal.all.each do |record|
      @user_journal = UserJournal.create(:journal_id => record.journal_id, :startyear => record.year,
                                         :startmonth => record.month, :user_id => record.user_id)
      if @user_journal.valid?
        record.destroy
      end
    end
  end
end
