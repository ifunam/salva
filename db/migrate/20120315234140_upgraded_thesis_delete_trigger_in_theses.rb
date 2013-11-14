class UpgradedThesisDeleteTriggerInTheses < ActiveRecord::Migration
  def up
    execute "DROP FUNCTION IF EXISTS thesis_delete()"

    execute %Q{
      CREATE FUNCTION thesis_delete() RETURNS trigger
        LANGUAGE plpgsql SECURITY DEFINER
        AS $$
      DECLARE
      BEGIN
        INSERT INTO theses_logs (thesis_id, old_thesisstatus_id, startyear, startmonth, endyear, endmonth,
                                 registered_by_id, modified_by_id)
        VALUES (OLD.id, OLD.thesisstatus_id, OLD.startyear, OLD.startmonth, OLD.endyear, OLD.endmonth,
                OLD.registered_by_id, OLD.modified_by_id);
        RETURN NULL;
      END;
      $$;
    }

    execute "CREATE TRIGGER thesis_delete AFTER DELETE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_delete()"
  end

  def down
    execute "DROP FUNCTION IF EXISTS thesis_delete()"

    execute %Q{
      CREATE FUNCTION thesis_delete() RETURNS trigger
        LANGUAGE plpgsql SECURITY DEFINER
        AS $$
      DECLARE
      BEGIN
        INSERT INTO theses_logs (thesis_id, old_thesisstatus_id, startyear, startmonth, endyear, endmonth,
                                 moduser_id)
        VALUES (OLD.id, OLD.thesisstatus_id, OLD.startyear, OLD.startmonth, OLD.endyear, OLD.endmonth, 
                OLD.moduser_id);
        RETURN NULL;
      END;
      $$;
    }

    execute "CREATE TRIGGER thesis_delete AFTER DELETE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_delete()"
  end
end
