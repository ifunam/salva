class MoveIdTypeIdToUserIdentificationsFromIdentifications < ActiveRecord::Migration
  def self.up
    UserIdentification.all.each do |record|
      record.update_attribute :idtype_id,  record.identification.idtype_id
    end
  end

  def self.down
    UserIdentification.all.each do |record|
      record.update_attribute :idtype_id, nil
    end
  end
end
