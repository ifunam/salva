class FillLevelAttributeInToThesismodalities < ActiveRecord::Migration
  def up
    Thesismodality.all.each do |record|
      record.update_attribute :level, record.id
    end
  end

  def down
  end
end
