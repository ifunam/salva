class UpgradedThesisUpdateTriggerToTheses < ActiveRecord::Migration
  def up
    execute "DROP FUNCTION IF EXISTS thesis_update()"

    execute %Q{
      CREATE FUNCTION thesis_update() RETURNS trigger
        LANGUAGE plpgsql SECURITY DEFINER
        AS $$
      DECLARE
      BEGIN
        IF OLD.thesisstatus_id = NEW.thesisstatus_id THEN
          RETURN NEW;
        END IF;
        INSERT INTO theses_logs (thesis_id, old_thesisstatus_id, startyear, 
                                 startmonth, endyear, endmonth,
                                 registered_by_id, modified_by_id)
          VALUES (OLD.id, OLD.thesisstatus_id, OLD.startyear, OLD.startmonth,
                  OLD.endyear, OLD.endmonth,  OLD.registered_by_id,
                  OLD.modified_by_id);
        RETURN NEW;
      END;
      $$;
    }

    execute "CREATE TRIGGER thesis_update BEFORE UPDATE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_update()"
  end

  def down
    execute "DROP FUNCTION IF EXISTS thesis_update()"

    execute %Q{
      CREATE FUNCTION thesis_update() RETURNS trigger
        LANGUAGE plpgsql SECURITY DEFINER
        AS $$
      DECLARE
      BEGIN
        IF OLD.thesisstatus_id = NEW.thesisstatus_id THEN
          RETURN NEW;
        END IF;
        INSERT INTO theses_logs (thesis_id, old_thesisstatus_id, startyear, startmonth, endyear, endmonth,  moduser_id)
          VALUES (OLD.id, OLD.thesisstatus_id, OLD.startyear, OLD.startmonth,
                  OLD.endyear, OLD.endmonth,  OLD.moduser_id);
        RETURN NEW;
      END;
      $$;
    }

    execute "CREATE TRIGGER thesis_update BEFORE UPDATE ON theses FOR EACH ROW EXECUTE PROCEDURE thesis_update()"
  end
end
