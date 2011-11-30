# encoding: utf-8
class InsertRefereedCriteria < ActiveRecord::Migration
  def self.up
    ['Artículo', 'Carta', 'Nota de investigación', 'Otro'].each do |name|
      RefereedCriterium.create(:name => name)
    end
  end

  def self.down
    RefereedCriterium.destroy_all
  end
end
