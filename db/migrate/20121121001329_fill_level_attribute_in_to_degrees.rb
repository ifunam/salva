class FillLevelAttributeInToDegrees < ActiveRecord::Migration
  def up
    Degree.all.each do |record|
      record.update_attribute :level, record.id
    end
  end

  def down
  end
end
