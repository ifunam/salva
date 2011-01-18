class FixOldDbUsercreditsColumns < ActiveRecord::Migration
  def self.up
    unless column_exists? :usercredits, :internalusergive_id
      add_column :usercredits, :internalusergive_id, :integer
    end

    unless column_exists? :usercredits, :externalusergive_id
      add_column :usercredits, :externalusergive_id, :integer
    end

    unless column_exists? :usercredits, :usergive_is_internal
      add_column :usercredits, :usergive_is_internal, :boolean
    end

    if column_exists? :usercredits, :usergive_id
      remove_column :usercredits, :usergive_id
    end

    if column_exists? :usercredits, :moduser_id
      remove_column :usercredits, :moduser_id
    end

    if column_exists? :usercredits, :created_at
      remove_column :usercredits, :created_at
    end

    if column_exists? :usercredits, :updated_at
      remove_column :usercredits, :updated_at
    end

#    execute "ALTER TABLE usercredits ADD CONSTRAINT usercredits_check CHECK (((usergive_is_internal = true) OR ((internalusergive_id IS NOT NULL) AND (externalusergive_id IS NULL))));"
#    execute "ALTER TABLE usercredits ADD CONSTRAINT usercredits_check1 CHECK (((usergive_is_internal = false) OR ((externalusergive_id IS NOT NULL) AND (internalusergive_id IS NULL))));"
    execute "COMMENT ON TABLE usercredits IS 'Agradecimientos, créditos y reconocimientos por apoyo técnico';"
    execute "COMMENT ON COLUMN usercredits.usergive_is_internal IS 'Quien otorga el agradecimiento es usuario interno o externo? Exige (NOT NULL) el tipo de usuario adecuado: externalusergive_id o internalusergive_id';"

  end

  def self.down
  end
end
