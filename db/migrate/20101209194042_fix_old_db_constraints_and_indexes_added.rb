class FixOldDbConstraintsAndIndexesAdded < ActiveRecord::Migration
  def self.up
    unless index_name_exists? :student_activities, :student_activities_user_id_key1, :default
      execute "ALTER TABLE ONLY student_activities ADD CONSTRAINT student_activities_user_id_key1 UNIQUE (user_id, tutor_externaluser_id);"
    end
    unless index_name_exists? :studentroles, :studentroles_name_key, :default
      execute "ALTER TABLE ONLY studentroles ADD CONSTRAINT studentroles_name_key UNIQUE (name);"
    end
    unless index_name_exists? :user_cites, :user_cites_user_id_key, :default
      execute "ALTER TABLE ONLY user_cites ADD CONSTRAINT user_cites_user_id_key UNIQUE (user_id);"
    end
    unless index_name_exists? :userrefereedpubs, :userrefereedpubs_refereedpubs_id_key, :default
      execute "ALTER TABLE ONLY userrefereedpubs ADD CONSTRAINT userrefereedpubs_refereedpubs_id_key UNIQUE (refereedpubs_id, externaluser_id, internaluser_id);"
    end
    unless index_name_exists? :userresearchgroups, :userresearchgroups_researchgroup_id_key, :default
      execute "ALTER TABLE ONLY userresearchgroups ADD CONSTRAINT userresearchgroups_researchgroup_id_key UNIQUE (researchgroup_id, internaluser_id);"
    end
    unless index_name_exists? :userresearchgroups, :userresearchgroups_researchgroup_id_key1, :default
      execute "ALTER TABLE ONLY userresearchgroups ADD CONSTRAINT userresearchgroups_researchgroup_id_key1 UNIQUE (researchgroup_id, externaluser_id);"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'user_stimulus_stimuluslevel_id_fkey'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE ONLY user_stimuli ADD CONSTRAINT user_stimulus_stimuluslevel_id_fkey FOREIGN KEY (stimuluslevel_id) REFERENCES stimuluslevels(id) ON UPDATE CASCADE DEFERRABLE"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'usercredits_internalusergive_id_fkey'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE ONLY usercredits ADD CONSTRAINT usercredits_internalusergive_id_fkey FOREIGN KEY (internalusergive_id) REFERENCES users(id) ON UPDATE CASCADE DEFERRABLE"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'usercredits_user_id_fkey'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE ONLY usercredits ADD CONSTRAINT usercredits_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE DEFERRABLE;"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'userrefereedpubs_internaluser_id_fkey'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE ONLY userrefereedpubs ADD CONSTRAINT userrefereedpubs_internaluser_id_fkey FOREIGN KEY (internaluser_id) REFERENCES users(id) ON UPDATE CASCADE DEFERRABLE;"
    end

    pg_result = execute("SELECT conname FROM pg_constraint WHERE conname = 'userresearchgroups_internaluser_id_fkey'")
    if pg_result.ntuples == 0
      execute "ALTER TABLE ONLY userresearchgroups ADD CONSTRAINT userresearchgroups_internaluser_id_fkey FOREIGN KEY (internaluser_id) REFERENCES users(id) ON UPDATE CASCADE DEFERRABLE;"
    end

    # CREATE INDEX index_versions_on_created_at ON versions USING btree (created_at);
    unless index_name_exists? :versions, :index_versions_on_created_at, :default
      add_index :versions, :created_at, :name => :index_versions_on_created_at
    end


    # CREATE INDEX user_id_and_article_id_idx ON user_articles USING btree (user_id, article_id);
    unless index_name_exists? :user_articles, :user_id_and_article_id_idx, :default
      add_index :user_articles, [:user_id, :article_id], :name => :user_id_and_article_id_idx
    end

    # CREATE UNIQUE INDEX academicprogramtypes_name_key ON academicprogramtypes USING btree (name);
    unless index_name_exists? :academicprogramtypes, :academicprogramtypes_name_key, :default
      add_index :academicprogramtypes, :name, :name => :academicprogramtypes_name_key, :unique => true
    end

    # CREATE UNIQUE INDEX people_id_key ON people USING btree (id);
    unless index_name_exists? :people, :people_id_key, :default
      add_index :people, :id, :name => :people_id_key, :unique => true
    end
  end

  def self.down
  end
end
