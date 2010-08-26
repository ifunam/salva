class UpdateContractypes < ActiveRecord::Migration
  def self.up
    Contracttype.create(:name => 'Otro')
  end

  def self.down
    Contracttype.where(:name => 'Otro').first.destroy
  end
end
