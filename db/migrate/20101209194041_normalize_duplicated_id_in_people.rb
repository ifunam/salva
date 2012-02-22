class NormalizeDuplicatedIdInPeople < ActiveRecord::Migration

  def self.up
    last_id = Person.unscoped.order("id DESC").first.id
    Person.all.each do |record|
      last_id += 1
      execute "UPDATE people SET id = #{last_id} WHERE user_id = #{record.user_id}"
    end

  end

  def self.down
  end
end
