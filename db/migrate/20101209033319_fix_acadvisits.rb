# encoding: utf-8
class FixAcadvisits < ActiveRecord::Migration
  def self.up
    unless column_exists? :acadvisits, :externaluser_id
      add_column :acadvisits, :externaluser_id, :integer
      execute "COMMENT ON COLUMN acadvisits.externaluser_id IS 'Si esta columna apunta a un usuario externo, significa que el usuario participo en la coordinación de una visita o estancia académica de un invitado';"
    end
  end

  def self.down
  end
end
