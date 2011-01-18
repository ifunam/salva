class FixOldDbBookeditionsColumns < ActiveRecord::Migration
  def self.up
    # ¿c'omo saber si el campo es de un tipo en particular?
    # if Bookedition.pages.is_a? Integer
    #   add_column :bookeditions, :temp_pages, :string
    #   Bookedition.find(:all).each do |record|
    #     record.temp_pages = record.pages
    #     record.save
    #   end
    #   drop_column :bookeditions, :pages
    #   rename_column :bookeditions, :temp_pages, :pages
    # end
    change_column :bookeditions, :pages, :text
  end

  def self.down
  end
end
