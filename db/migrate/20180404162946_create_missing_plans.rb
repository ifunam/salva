class CreateMissingPlans < ActiveRecord::Migration
  def change
    execute "create or replace view missing_plans as select * from users where id in (select id from users where userstatus_id=2 except select user_id from annual_plans join documenttypes on annual_plans.documenttype_id=documenttypes.id where documenttypes.name like '%lan de trabajo%' and documenttypes.year=date_part('year', CURRENT_DATE)) order by author_name;"
  end
end
