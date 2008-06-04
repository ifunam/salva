class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :academicprograms, :force => true do |t|
      t.references :institutioncareer, :academicprogramtype, :null => false
      t.integer :year, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :academicprogramtypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :academicprogramtypes, [:name], :name => :academicprogramtypes_name_key, :unique => true

    create_table :acadvisits, :force => true do |t|
      t.references :user, :institution, :country, :acadvisittype, :null => false
      t.references :externaluser
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :descr, :null => false
      t.text :place, :goals, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :acadvisittypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :acadvisittypes, [:name], :name => :acadvisittypes_name_key, :unique => true

    create_table :actions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :actions, [:name], :name => :actions_name_key, :unique => true

    create_table :activities, :force => true do |t|
      t.references :user, :activitytype, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :activities, [:activitytype_id, :month, :name, :year], :name => :activities_activitytype_id_key, :unique => true

    create_table :activitygroups, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :activitygroups, [:name], :name => :activitygroups_name_key, :unique => true

    create_table :activitytypes, :force => true do |t|
      t.references :activitygroup, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :activitytypes, [:name], :name => :activitytypes_name_key, :unique => true

    create_table :addresses, :force => true do |t|
      t.references :user, :addresstype, :country, :null => false
      t.references :state, :city
      t.integer :zipcode
      t.text :location, :null => false
      t.text :pobox, :phone, :fax, :movil, :other
      t.boolean :is_postaddress, :default => false, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :addresses, [:addresstype_id, :user_id], :name => :addresses_user_id_key, :unique => true

    create_table :addresstypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :addresstypes, [:name], :name => :addresstypes_name_key, :unique => true

    create_table :adscriptions, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.text :abbrev, :descr, :administrative_key
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :adscriptions, [:institution_id, :name], :name => :adscriptions_name_key, :unique => true

    create_table :adviceactivities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :adviceactivities, [:name], :name => :adviceactivities_name_key, :unique => true

    create_table :articles, :force => true do |t|
      t.references :journal, :articlestatus, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :title, :authors, :null => false
      t.text :pages, :vol, :num, :url, :pacsnum, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :articlesfiles, :force => true do |t|
      t.references :articles, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :articlesfiles, [:articles_id, :filename], :name => :articlesfiles_articles_id_key, :unique => true
    add_index :articlesfiles, [:articles_id], :name => :articlesfiles_articles_idx
    add_index :articlesfiles, [:filename], :name => :articlesfiles_filename_idx

    create_table :articleslog, :force => true do |t|
      t.references :article, :null => false
      t.references :old_articlestatus, :class_name => 'Articlestatus', :foreign_key=> 'old_articlestatus_id', :null => false
      t.date :changedate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :articlestatuses, :force => true do |t|
      t.string :name, :limit => 50, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :articlestatuses, [:name], :name => :articlestatuses_name_key, :unique => true

    create_table :bookchaptertypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :bookchaptertypes, [:name], :name => :bookchaptertypes_name_key, :unique => true

    create_table :bookedition_comments, :force => true do |t|
      t.references :user, :bookedition, :null => false
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :bookedition_comments, [:bookedition_id, :user_id], :name => :bookedition_comments_user_id_key, :unique => true

    create_table :bookedition_publishers, :force => true do |t|
      t.references :bookedition, :publisher, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :bookedition_publishers, [:bookedition_id, :publisher_id], :name => :bookedition_publishers_bookedition_id_key, :unique => true

    create_table :bookedition_roleinbooks, :force => true do |t|
      t.references :user, :bookedition, :roleinbook, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :bookeditions, :force => true do |t|
      t.references :book, :mediatype, :null => false
      t.references :editionstatus
      t.integer :year, :null => false
      t.integer :pages, :month
      t.text :edition, :null => false
      t.text :isbn, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :books, :force => true do |t|
      t.references :country, :booktype, :null => false
      t.references :language
      t.text :title, :authors, :null => false
      t.text :booklink, :volume
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :booktypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :booktypes, [:name], :name => :booktypes_name_key, :unique => true

    create_table :careers, :force => true do |t|
      t.references :degree, :null => false
      t.text :name, :null => false
      t.text :abbrev
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :chapterinbook_comments, :force => true do |t|
      t.references :user, :chapterinbook, :null => false
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :chapterinbook_comments, [:chapterinbook_id, :user_id], :name => :chapterinbook_comments_user_id_key, :unique => true

    create_table :chapterinbook_roleinchapters, :force => true do |t|
      t.references :user, :chapterinbook, :roleinchapter, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :chapterinbooks, :force => true do |t|
      t.references :bookedition, :bookchaptertype, :null => false
      t.text :title, :null => false
      t.text :pages
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :chapterinbooks, [:title], :name => :chapterinbooks_title_idx

    create_table :cities, :force => true do |t|
      t.references :state, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :cities, [:name, :state_id], :name => :cities_state_id_key, :unique => true

    create_table :citizenmodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :citizenmodalities, [:name], :name => :citizenmodalities_name_key, :unique => true

    create_table :citizens, :force => true do |t|
      t.references :user, :migratorystatus, :citizenmodality, :null => false
      t.references :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id', :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :citizens, [:citizen_country_id, :user_id], :name => :citizens_user_id_key, :unique => true

    create_table :conference_institutions, :force => true do |t|
      t.references :conference, :institution, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :conference_institutions, [:conference_id, :institution_id], :name => :conference_institutions_conference_id_key, :unique => true

    create_table :conferences, :force => true do |t|
      t.references :conferencetype, :country, :null => false
      t.references :conferencescope
      t.integer :year, :null => false
      t.integer :month
      t.text :name, :null => false
      t.text :url, :location, :other
      t.boolean :isspecialized, :default => false, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :conferencescopes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :conferencescopes, [:name], :name => :conferencescopes_name_key, :unique => true

    create_table :conferencetalks, :force => true do |t|
      t.references :conference, :talktype, :talkacceptance, :modality, :null => false
      t.text :title, :authors, :null => false
      t.text :abstract
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :conferencetalks, [:authors, :conference_id, :talktype_id, :title], :name => :conferencetalks_conference_id_key, :unique => true

    create_table :conferencetalksfiles, :force => true do |t|
      t.references :conferencetalks, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :conferencetalksfiles, [:conferencetalks_id, :filename], :name => :conferencetalksfiles_conferencetalks_id_key, :unique => true
    add_index :conferencetalksfiles, [:conferencetalks_id], :name => :conferencetalksfiles_conferencetalks_idx
    add_index :conferencetalksfiles, [:filename], :name => :conferencetalksfiles_filename_idx

    create_table :conferencetypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :conferencetypes, [:name], :name => :conferencetypes_name_key, :unique => true

    create_table :contracttypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :contracttypes, [:name], :name => :contracttypes_name_key, :unique => true

    create_table :controllers, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :controllers, [:name], :name => :controllers_name_key, :unique => true

    create_table :countries, :force => true do |t|
      t.text :name, :citizen, :null => false
      t.string :code, :limit => 3, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :countries, [:code], :name => :countries_code_key, :unique => true
    add_index :countries, [:name], :name => :countries_name_key, :unique => true

    create_table :coursedurations, :force => true do |t|
      t.integer :days, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :coursedurations, [:name], :name => :coursedurations_name_key, :unique => true

    create_table :coursegroups, :force => true do |t|
      t.references :coursegrouptype, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth, :totalhours
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :coursegroups, [:coursegrouptype_id, :endmonth, :endyear, :name, :startmonth, :startyear], :name => :coursegroups_name_key, :unique => true

    create_table :coursegrouptypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :coursegrouptypes, [:name], :name => :coursegrouptypes_name_key, :unique => true

    create_table :courses, :force => true do |t|
      t.references :country, :courseduration, :modality, :null => false
      t.references :institution, :coursegroup
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth, :hoursxweek, :totalhours
      t.text :name, :null => false
      t.text :location
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :credentials, :force => true do |t|
      t.text :name, :null => false
      t.text :abbrev
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :credentials, [:name], :name => :credentials_name_key, :unique => true

    create_table :credittypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :credittypes, [:name], :name => :credittypes_name_key, :unique => true

    create_table :degrees, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :degrees, [:name], :name => :degrees_name_key, :unique => true

    create_table :documents, :force => true do |t|
      t.references :documenttype, :null => false
      t.text :title, :null => false
      t.date :startdate, :null => false
      t.date :enddate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :documents, [:documenttype_id, :title], :name => :documents_documenttype_id_key, :unique => true

    create_table :documenttypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :documenttypes, [:name], :name => :documenttypes_name_key, :unique => true

    create_table :editions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :editions, [:name], :name => :editions_name_key, :unique => true

    create_table :editionstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :editionstatuses, [:name], :name => :editionstatuses_name_key, :unique => true

    create_table :externaluserlevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :externaluserlevels, [:name], :name => :externaluserlevels_name_key, :unique => true

    create_table :externalusers, :force => true do |t|
      t.references :institution, :externaluserlevel, :degree
      t.text :firstname, :lastname1, :null => false
      t.text :lastname2
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :file_articles, :force => true do |t|
      t.references :article, :null => false
      t.text :filename, :null => false
      t.text :conten_type
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :file_articles, [:article_id, :filename], :name => :file_articles_article_id_key, :unique => true

    create_table :genericworkgroups, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :genericworkgroups, [:name], :name => :genericworkgroups_name_key, :unique => true

    create_table :genericworks, :force => true do |t|
      t.references :genericworktype, :genericworkstatus, :null => false
      t.references :institution, :publisher
      t.integer :year, :null => false
      t.integer :month
      t.text :title, :authors, :null => false
      t.text :reference, :vol, :pages, :isbn_issn, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :genericworksfiles, :force => true do |t|
      t.references :genericworks, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :genericworksfiles, [:filename], :name => :genericworksfiles_filename_idx
    add_index :genericworksfiles, [:filename, :genericworks_id], :name => :genericworksfiles_genericworks_id_key, :unique => true
    add_index :genericworksfiles, [:genericworks_id], :name => :genericworksfiles_genericworks_idx

    create_table :genericworkslog, :force => true do |t|
      t.references :genericwork, :null => false
      t.references :old_genericworkstatus, :class_name => 'Genericworkstatus', :foreign_key => 'old_genericworkstatus_id', :null => false
      t.date :changedate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :genericworkstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :genericworkstatuses, [:name], :name => :genericworkstatuses_name_key, :unique => true

    create_table :genericworktypes, :force => true do |t|
      t.references :genericworkgroup, :null => false
      t.text :name, :null => false
      t.text :abbrev
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :genericworktypes, [:genericworkgroup_id, :name], :name => :genericworktypes_name_key, :unique => true

    create_table :grants, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :grants, [:institution_id, :name], :name => :grants_name_key, :unique => true

    create_table :groupmodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :groupmodalities, [:name], :name => :groupmodalities_name_key, :unique => true

    create_table :groups, :force => true do |t|
      t.references :parent
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :groups, [:name, :parent_id], :name => :groups_name_key, :unique => true

    create_table :identifications, :force => true do |t|
      t.references :idtype, :null => false
      t.references :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id', :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :identifications, [:citizen_country_id, :idtype_id], :name => :identifications_idtype_id_key, :unique => true

    create_table :idtypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :idtypes, [:name], :name => :idtypes_name_key, :unique => true

    create_table :indivadviceprograms, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :indivadviceprograms, [:name], :name => :indivadviceprograms_name_key, :unique => true

    create_table :indivadvices, :force => true do |t|
      t.references :user, :indivadvicetarget, :null => false
      t.references :indivuser, :institution, :indivadviceprogram, :degree
      t.integer :startyear, :hours, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :indivname, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :indivadvicetargets, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :indivadvicetargets, [:name], :name => :indivadvicetargets_name_key, :unique => true

    create_table :inproceedings, :force => true do |t|
      t.references :proceeding, :null => false
      t.text :title, :authors, :null => false
      t.text :pages, :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :instadviceactivities, :force => true do |t|
      t.references :instadvice, :adviceactivity, :null => false
      t.text :duration
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :instadviceactivities, [:adviceactivity_id, :instadvice_id], :name => :instadviceactivities_instadvice_id_key, :unique => true

    create_table :instadvices, :force => true do |t|
      t.references :user, :institution, :instadvicetarget, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :title, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :instadvicetargets, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :instadvicetargets, [:name], :name => :instadvicetargets_name_key, :unique => true

    create_table :institutional_activities, :force => true do |t|
      t.references :user, :institution, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endmonth, :endyear
      t.text :descr, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :institutioncareers, :force => true do |t|
      t.references :institution, :career, :null => false
      t.text :url, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :institutioncareers, [:career_id, :institution_id], :name => :institutioncareers_institution_id_key, :unique => true

    create_table :institutions, :force => true do |t|
      t.references :institutiontype, :institutiontitle, :country, :null => false
      t.references :institution, :state, :city
      t.text :name, :null => false
      t.text :url, :abbrev, :addr, :zipcode, :phone, :fax, :administrative_key, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :institutiontitles, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :institutiontitles, [:name], :name => :institutiontitles_name_key, :unique => true

    create_table :institutiontypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :institutiontypes, [:name], :name => :institutiontypes_name_key, :unique => true

    create_table :jobposition_logs, :force => true do |t|
      t.references :user, :null => false
      t.integer :academic_years, :administrative_years
      t.text :worker_key, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :jobposition_logs, [:user_id], :name => :jobposition_logs_user_id_key, :unique => true
    add_index :jobposition_logs, [:worker_key], :name => :jobposition_logs_worker_key_key, :unique => true

    create_table :jobpositioncategories, :force => true do |t|
      t.references :jobpositiontype, :roleinjobposition, :null => false
      t.references :jobpositionlevel
      t.text :administrative_key
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :jobpositionlevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :jobpositionlevels, [:name], :name => :jobpositionlevels_name_key, :unique => true

    create_table :jobpositionlog, :force => true do |t|
      t.references :user, :institution, :null => false
      t.references :old_jobpositioncategory, :class_name => 'Jobpositioncategory', :foreign_key => 'old_jobpositioncategory_id'
      t.references :old_contracttype, :class_name => 'Contracttype', :foreing_key => 'old_contracttype_id'
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :old_descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :jobpositions, :force => true do |t|
      t.references :user, :institution, :null => false
      t.references :jobpositioncategory, :contracttype
      t.integer :startyear, :null => false
      t.integer :startmonth, :endmonth, :endyear
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :jobpositiontypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :jobpositiontypes, [:name], :name => :jobpositiontypes_name_key, :unique => true

    create_table :journal_publicationcategories, :force => true do |t|
      t.references :journal, :publicationcategory, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :journal_publicationcategories, [:journal_id, :publicationcategory_id], :name => :journal_publicationcategories_journal_id_key, :unique => true

    create_table :journals, :force => true do |t|
      t.references :mediatype, :country, :null => false
      t.references :publisher
      t.text :name, :null => false
      t.text :issn, :url, :abbrev, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :journals, [:country_id, :issn, :mediatype_id, :name], :name => :journals_name_key, :unique => true

    create_table :languagelevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :languagelevels, [:name], :name => :languagelevels_name_key, :unique => true

    create_table :languages, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :languages, [:name], :name => :languages_name_key, :unique => true

    create_table :maritalstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :maritalstatuses, [:name], :name => :maritalstatuses_name_key, :unique => true

    create_table :mediatypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :mediatypes, [:name], :name => :mediatypes_name_key, :unique => true

    create_table :memberships, :force => true do |t|
      t.references :user, :institution, :null => false
      t.integer :startyear, :endyear
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :migratorystatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :migratorystatuses, [:name], :name => :migratorystatuses_name_key, :unique => true

    create_table :modalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :modalities, [:name], :name => :modalities_name_key, :unique => true

    create_table :newspaperarticles, :force => true do |t|
      t.references :newspaper, :null => false
      t.text :title, :authors, :null => false
      t.text :pages, :url
      t.date :newsdate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :newspapers, :force => true do |t|
      t.references :country, :null => false
      t.text :name, :null => false
      t.text :url
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :newspapers, [:name], :name => :newspapers_name_key, :unique => true

    create_table :people, :id => false, :force => true do |t|
      t.references :user, :country, :null => false
      t.references :maritalstatus, :state, :city
      t.text :firstname, :lastname1, :null => false
      t.text :lastname2, :photo_filename, :photo_content_type, :other
      t.boolean :gender, :null => false
      t.date :dateofbirth, :null => false
      t.binary :photo
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :people, [:firstname], :name => :people_firstname_idx
    add_index :people, [:lastname1], :name => :people_lastname1_idx
    add_index :people, [:lastname2], :name => :people_lastname2_idx

    create_table :people_identifications, :force => true do |t|
      t.references :user, :identification, :null => false
      t.text :descr, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :people_identifications, [:identification_id, :user_id], :name => :people_identifications_user_id_key, :unique => true

    create_table :periods, :force => true do |t|
      t.text :title, :null => false
      t.date :startdate, :null => false
      t.date :enddate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :periods, [:title], :name => :periods_title_key, :unique => true
    add_index :periods, [:enddate, :startdate, :title], :name => :periods_title_key1, :unique => true

    create_table :permissions, :force => true do |t|
      t.references :roleingroup, :controller, :action, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :permissions, [:action_id, :controller_id, :roleingroup_id], :name => :permissions_roleingroup_id_key, :unique => true

    create_table :plan, :force => true do |t|
      t.references :user, :null => false
      t.integer :year, :null => false
      t.text :plan, :null => false
      t.binary :extendedinfo
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :prizes, :force => true do |t|
      t.references :prizetype, :institution, :null => false
      t.text :name, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :prizetypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :prizetypes, [:name], :name => :prizetypes_name_key, :unique => true

    create_table :probatory_documents, :force => true do |t|
      t.references :user, :probatorydoctype, :null => false
      t.text :filename, :content_type, :null => false
      t.text :other
      t.binary :file, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :probatory_documents, [:probatorydoctype_id, :user_id], :name => :probatory_documents_user_id_key, :unique => true

    create_table :probatorydoctypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :probatorydoctypes, [:name], :name => :probatorydoctypes_name_key, :unique => true

    create_table :proceedings, :force => true do |t|
      t.references :conference, :null => false
      t.references :publisher
      t.integer :year
      t.text :title, :null => false
      t.text :volume, :other
      t.boolean :isrefereed, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :professionaltitles, :force => true do |t|
      t.references :schooling, :titlemodality, :null => false
      t.integer :year
      t.text :professionalid, :thesistitle
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :professionaltitles, [:schooling_id], :name => :professionaltitles_schooling_id_key, :unique => true

    create_table :projectacadvisits, :force => true do |t|
      t.references :project, :acadvisit, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectacadvisits, [:acadvisit_id, :project_id], :name => :projectacadvisits_project_id_key, :unique => true

    create_table :projectarticles, :force => true do |t|
      t.references :project, :article, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectarticles, [:article_id, :project_id], :name => :projectarticles_project_id_key, :unique => true

    create_table :projectconferencetalks, :force => true do |t|
      t.references :project, :conferencetalk, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectconferencetalks, [:conferencetalk_id, :project_id], :name => :projectconferencetalks_project_id_key, :unique => true

    create_table :projectfiles, :force => true do |t|
      t.references :project, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectfiles, [:filename, :project_id], :name => :projectfiles_project_id_key, :unique => true

    create_table :projectfinancingsources, :force => true do |t|
      t.references :project, :institution, :null => false
      t.text :other
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectfinancingsources, [:institution_id, :project_id], :name => :projectfinancingsources_project_id_key, :unique => true

    create_table :projectgenericworks, :force => true do |t|
      t.references :project, :genericwork, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectgenericworks, [:genericwork_id, :project_id], :name => :projectgenericworks_project_id_key, :unique => true

    create_table :projectinstitutions, :force => true do |t|
      t.references :project, :institution, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectinstitutions, [:institution_id, :project_id], :name => :projectinstitutions_project_id_key, :unique => true

    create_table :projectresearchareas, :force => true do |t|
      t.references :project, :researcharea, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectresearchareas, [:project_id, :researcharea_id], :name => :projectresearchareas_project_id_key, :unique => true

    create_table :projectresearchlines, :force => true do |t|
      t.references :project, :researchline, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectresearchlines, [:project_id, :researchline_id], :name => :projectresearchlines_project_id_key, :unique => true

    create_table :projects, :force => true do |t|
      t.references :projecttype, :projectstatus, :null => false
      t.references :project
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :name, :responsible, :descr, :null => false
      t.text :abstract, :abbrev, :url, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projects, [:descr], :name => :projects_descr_idx
    add_index :projects, [:name], :name => :projects_name_idx

    create_table :projectstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projectstatuses, [:name], :name => :projectstatuses_name_key, :unique => true

    create_table :projecttheses, :force => true do |t|
      t.references :project, :thesis, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projecttheses, [:project_id, :thesis_id], :name => :projecttheses_project_id_key, :unique => true

    create_table :projecttypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :projecttypes, [:name], :name => :projecttypes_name_key, :unique => true

    create_table :publicationcategories, :force => true do |t|
      t.text :descr
      t.string :name, :limit => 50, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :publicationcategories, [:name], :name => :publicationcategories_name_key, :unique => true

    create_table :publishers, :force => true do |t|
      t.text :name, :null => false
      t.text :descr, :url
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :publishers, [:name], :name => :publishers_name_key, :unique => true

    create_table :pubtorefereed, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :pubtorefereed, [:name], :name => :pubtorefereed_name_key, :unique => true

    create_table :refereedpubs, :force => true do |t|
      t.references :pubtorefereed, :institution, :null => false
      t.text :title, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :regularcourses, :force => true do |t|
      t.references :modality, :null => false
      t.references :academicprogram
      t.integer :semester, :credits
      t.text :title, :null => false
      t.text :administrative_key, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :researchareas, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :researchareas, [:name], :name => :researchareas_name_key, :unique => true

    create_table :researchgroupmodalities, :force => true do |t|
      t.references :researchgroup, :null => false
      t.references :groupmodality, :adscription
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :researchgroups, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :researchgroups, [:name], :name => :researchgroups_name_key, :unique => true

    create_table :researchlines, :force => true do |t|
      t.references :researcharea
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :reviews, :force => true do |t|
      t.references :user, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :authors, :title, :published_on, :reviewed_work_title, :null => false
      t.text :reviewed_work_publication, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinbooks, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinbooks, [:name], :name => :roleinbooks_name_key, :unique => true

    create_table :roleinchapters, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinchapters, [:name], :name => :roleinchapters_name_key, :unique => true

    create_table :roleinconferences, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinconferences, [:name], :name => :roleinconferences_name_key, :unique => true

    create_table :roleinconferencetalks, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinconferencetalks, [:name], :name => :roleinconferencetalks_name_key, :unique => true

    create_table :roleincourses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleincourses, [:name], :name => :roleincourses_name_key, :unique => true

    create_table :roleingroups, :force => true do |t|
      t.references :group, :role, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleingroups, [:group_id, :role_id], :name => :roleingroups_group_id_key, :unique => true

    create_table :roleinjobpositions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinjobpositions, [:name], :name => :roleinjobpositions_name_key, :unique => true

    create_table :roleinjournals, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinjournals, [:name], :name => :roleinjournals_name_key, :unique => true

    create_table :roleinjuries, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinjuries, [:name], :name => :roleinjuries_name_key, :unique => true

    create_table :roleinprojects, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinprojects, [:name], :name => :roleinprojects_name_key, :unique => true

    create_table :roleinregularcourses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinregularcourses, [:name], :name => :roleinregularcourses_name_key, :unique => true

    create_table :roleinseminaries, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleinseminaries, [:name], :name => :roleinseminaries_name_key, :unique => true

    create_table :roleintheses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleintheses, [:name], :name => :roleintheses_name_key, :unique => true

    create_table :roleproceedings, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roleproceedings, [:name], :name => :roleproceedings_name_key, :unique => true

    create_table :roles, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.boolean :has_group_right, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :roles, [:name], :name => :roles_name_key, :unique => true

    create_table :schema_info, :id => false, :force => true do |t|
      t.integer :version
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :schoolarships, :force => true do |t|
      t.references :institution
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :schoolarships, [:institution_id, :name], :name => :schoolarships_name_key, :unique => true

    create_table :schooling_files, :force => true do |t|
      t.references :schooling, :null => false
      t.references :schooling_filetype, :class_name => 'Filetype', :foreing_key => 'schooling_filetype_id', :null => false
      t.text :filename, :null => false
      t.text :content_type
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :schooling_files, [:schooling_filetype_id, :schooling_id], :name => :schooling_files_schooling_id_key, :unique => true

    create_table :schooling_filetypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :schooling_filetypes, [:name], :name => :schooling_filetypes_name_key, :unique => true

    create_table :schoolings, :force => true do |t|
      t.references :user, :institutioncareer, :null => false
      t.integer :startyear, :null => false
      t.integer :endyear, :credits
      t.text :studentid, :other
      t.float :average
      t.boolean :is_studying_this, :default => false, :null => false
      t.boolean :is_titleholder, :default => false, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :schoolings, [:institutioncareer_id, :user_id], :name => :schoolings_user_id_key, :unique => true

    create_table :selfevaluation, :force => true do |t|
      t.references :user, :null => false
      t.integer :year, :null => false
      t.text :plan, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :seminaries, :force => true do |t|
      t.references :seminarytype, :institution, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :title, :null => false
      t.text :url, :auditorium
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :seminarytypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :seminarytypes, [:name], :name => :seminarytypes_name_key, :unique => true

    create_table :sessions, :force => true do |t|
      t.references :session
      t.text :data
      t.datetime :updated_at
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :sessions, [:session_id], :name => :sessions_session_id_index

    create_table :skilltypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :skilltypes, [:name], :name => :skilltypes_name_key, :unique => true

    create_table :sponsor_acadvisits, :force => true do |t|
      t.references :acadvisit, :institution, :null => false
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :states, :force => true do |t|
      t.references :country, :null => false
      t.text :name, :null => false
      t.text :code
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :states, [:name], :name => :states_name_key, :unique => true

    create_table :stimuluslevels, :force => true do |t|
      t.references :stimulustype, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :stimulustypes, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :student_activities, :force => true do |t|
      t.references :user, :schooling, :studentroles
      t.references :tutor_user, :class_name => 'User', :foreing_key => 'tutor_user_id'
      t.references :tutor_externaluser, :class_name => 'Externaluser', :foreing_key => 'tutor_externaluser_id'
      t.boolean :tutor_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :student_activities, [:tutor_user_id, :user_id], :name => :student_activities_user_id_key, :unique => true
    add_index :student_activities, [:tutor_externaluser_id, :user_id], :name => :student_activities_user_id_key1, :unique => true

    create_table :studentroles, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :studentroles, [:name], :name => :studentroles_name_key, :unique => true

    create_table :talkacceptances, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :talkacceptances, [:name], :name => :talkacceptances_name_key, :unique => true

    create_table :talktypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :talktypes, [:name], :name => :talktypes_name_key, :unique => true

    create_table :techproducts, :force => true do |t|
      t.references :techproducttype, :techproductstatus, :null => false
      t.references :institution
      t.text :title, :authors, :null => false
      t.text :descr, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :techproductstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :techproductstatuses, [:name], :name => :techproductstatuses_name_key, :unique => true

    create_table :techproducttypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :theses, :force => true do |t|
      t.references :institutioncareer, :thesisstatus, :thesismodality, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :title, :authors, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :theses_logs, :force => true do |t|
      t.references :thesis, :null => false
      t.references :old_thesisstatus, :class_name => 'Thesisstatus', :foreing_key => 'old_thesisstatus_id', :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :thesis_jurors, :force => true do |t|
      t.references :user, :thesis, :roleinjury, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :thesismodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :thesismodalities, [:name], :name => :thesismodalities_name_key, :unique => true

    create_table :thesisstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :thesisstatuses, [:name], :name => :thesisstatuses_name_key, :unique => true

    create_table :titlemodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :titlemodalities, [:name], :name => :titlemodalities_name_key, :unique => true

    create_table :trashes, :force => true do |t|
      t.datetime :created_at
      t.datetime :updated_at
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :tutorial_committees, :force => true do |t|
      t.references :user, :degree, :institutioncareer, :null => false
      t.integer :year, :null => false
      t.text :studentname, :null => false
      t.text :descr, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_adscriptions, :force => true do |t|
      t.references :user, :jobposition, :adscription, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endmonth, :endyear
      t.text :name, :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_articles, :force => true do |t|
      t.references :user, :article, :null => false
      t.text :other
      t.boolean :ismainauthor, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_cites, :force => true do |t|
      t.references :user, :null => false
      t.integer :total, :null => false
      t.text :author_name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_cites, [:user_id], :name => :user_cites_user_id_key, :unique => true

    create_table :user_cites_logs, :force => true do |t|
      t.references :user, :null => false
      t.integer :total, :year, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_cites_logs, [:user_id, :year], :name => :user_cites_logs_user_id_key, :unique => true

    create_table :user_conferencetalks, :force => true do |t|
      t.references :user, :roleinconferencetalk, :null => false
      t.references :conferencetalk
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_conferencetalks, [:conferencetalk_id, :roleinconferencetalk_id, :user_id], :name => :user_conferencetalks_user_id_key, :unique => true

    create_table :user_courses, :force => true do |t|
      t.references :user, :course, :roleincourse, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_credits, :force => true do |t|
      t.references :credittype, :null => false
      t.references :user
      t.integer :year, :null => false
      t.integer :month
      t.text :descr, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_credits, [:credittype_id, :descr, :user_id, :year], :name => :user_credits_user_id_key, :unique => true

    create_table :user_creditsarticles, :force => true do |t|
      t.references :user, :article, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_creditsarticles, [:article_id, :user_id], :name => :user_creditsarticles_user_id_key, :unique => true

    create_table :user_creditsbookeditions, :force => true do |t|
      t.references :user, :bookedition, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_creditsbookeditions, [:bookedition_id, :user_id], :name => :user_creditsbookeditions_user_id_key, :unique => true

    create_table :user_creditschapterinbooks, :force => true do |t|
      t.references :user, :chapterinbook, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_creditschapterinbooks, [:chapterinbook_id, :user_id], :name => :user_creditschapterinbooks_user_id_key, :unique => true

    create_table :user_creditsconferencetalks, :force => true do |t|
      t.references :user, :conferencetalk, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_creditsconferencetalks, [:conferencetalk_id, :user_id], :name => :user_creditsconferencetalks_user_id_key, :unique => true

    create_table :user_creditsgenericworks, :force => true do |t|
      t.references :user, :genericwork, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_creditsgenericworks, [:genericwork_id, :user_id], :name => :user_creditsgenericworks_user_id_key, :unique => true

    create_table :user_document_logs, :force => true do |t|
      t.references :user, :null => false
      t.references :user_document, :class_name => 'Document', :foreing_key => 'user_document_id', :null => false
      t.text :prev_ip_address, :null => false
      t.boolean :prev_status, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_documents, :force => true do |t|
      t.references :user, :document, :null => false
      t.references :user_incharge, :class_name => 'User', :foreing_key => 'user_incharge_id'
      t.text :filename, :content_type, :ip_address, :null => false
      t.boolean :status, :default => false, :null => false
      t.binary :file, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_documents, [:document_id, :user_id], :name => :user_documents_user_id_key, :unique => true

    create_table :user_genericworks, :force => true do |t|
      t.references :genericwork, :user, :userrole, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_grants, :force => true do |t|
      t.references :grant, :user, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_grants, [:grant_id, :startmonth, :startyear, :user_id], :name => :user_grants_grant_id_key, :unique => true

    create_table :user_groups, :force => true do |t|
      t.references :user, :group, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_groups, [:group_id, :user_id], :name => :user_groups_user_id_key, :unique => true

    create_table :user_inproceedings, :force => true do |t|
      t.references :inproceeding, :user, :null => false
      t.boolean :ismainauthor, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_journals, :force => true do |t|
      t.references :user, :journal, :roleinjournal, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_languages, :force => true do |t|
      t.references :user, :language, :institution, :null => false
      t.references :spoken_languagelevel, :class_name => 'Languagelevel', :foreing_key => 'spoken_languagelevel_id',:null => false
      t.references :written_languagelevel, :class_name => 'Languagelevel', :foreing_key => 'written_languagelevel_id', :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_languages, [:institution_id, :language_id, :user_id], :name => :user_languages_language_id_key, :unique => true

    create_table :user_newspaperarticles, :force => true do |t|
      t.references :user, :newspaperarticle, :null => false
      t.text :other
      t.boolean :ismainauthor, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_prizes, :force => true do |t|
      t.references :user, :prize, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_proceedings, :force => true do |t|
      t.references :proceeding, :user, :roleproceeding, :null => false
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_projects, :force => true do |t|
      t.references :project, :user, :roleinproject, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_projects, [:project_id, :roleinproject_id, :user_id], :name => :user_projects_project_id_key, :unique => true

    create_table :user_regularcourses, :force => true do |t|
      t.references :user, :regularcourse, :period, :roleinregularcourse, :null => false
      t.integer :hoursxweek
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_researchlines, :force => true do |t|
      t.references :user, :researchline, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_roleingroups, :force => true do |t|
      t.references :user, :roleingroup, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_roleingroups, [:roleingroup_id, :user_id], :name => :user_roleingroups_user_id_key, :unique => true

    create_table :user_schoolarships, :force => true do |t|
      t.references :schoolarship, :user, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :descr
      t.decimal :amount, :precision => 10, :scale => 2
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_schoolarships, [:schoolarship_id, :startmonth, :startyear, :user_id], :name => :user_schoolarships_schoolarship_id_key, :unique => true

    create_table :user_seminaries, :force => true do |t|
      t.references :seminary, :user, :roleinseminary, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :user_seminaries, [:roleinseminary_id, :seminary_id, :user_id], :name => :user_seminaries_user_id_key, :unique => true

    create_table :user_skills, :force => true do |t|
      t.references :user, :skilltype, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_stimulus, :force => true do |t|
      t.references :user, :stimuluslevel, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_techproducts, :force => true do |t|
      t.references :user, :techproduct, :null => false
      t.references :userrole
      t.integer :year, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_theses, :force => true do |t|
      t.references :thesis, :user, :roleinthesis, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :userconferences, :force => true do |t|
      t.references :conference, :user, :roleinconference, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :usercredits, :force => true do |t|
      t.references :user, :internalusergive, :externalusergive
      t.integer :year, :null => false
      t.integer :month
      t.text :other
      t.boolean :usergive_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :usercreditsarticles, :force => true do |t|
      t.references :usercredits, :articles, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :usercreditsarticles, [:articles_id, :usercredits_id], :name => :usercreditsarticles_usercredits_id_key, :unique => true

    create_table :usercreditsbooks, :force => true do |t|
      t.references :usercredits, :books, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :usercreditsbooks, [:books_id, :usercredits_id], :name => :usercreditsbooks_usercredits_id_key, :unique => true

    create_table :usercreditsconferencetalks, :force => true do |t|
      t.references :usercredits, :conferencetalks, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :usercreditsconferencetalks, [:conferencetalks_id, :usercredits_id], :name => :usercreditsconferencetalks_usercredits_id_key, :unique => true

    create_table :usercreditsgenericworks, :force => true do |t|
      t.references :usercredits, :genericworks, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :usercreditsgenericworks, [:genericworks_id, :usercredits_id], :name => :usercreditsgenericworks_usercredits_id_key, :unique => true

    create_table :userrefereedpubs, :force => true do |t|
      t.references :refereedpubs, :null => false
      t.references :externaluser, :internaluser
      t.boolean :user_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :userrefereedpubs, [:externaluser_id, :internaluser_id, :refereedpubs_id], :name => :userrefereedpubs_refereedpubs_id_key, :unique => true

    create_table :userresearchgroups, :force => true do |t|
      t.references :researchgroup, :null => false
      t.references :externaluser, :internaluser
      t.integer :year, :null => false
      t.boolean :user_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :userresearchgroups, [:internaluser_id, :researchgroup_id], :name => :userresearchgroups_researchgroup_id_key, :unique => true
    add_index :userresearchgroups, [:externaluser_id, :researchgroup_id], :name => :userresearchgroups_researchgroup_id_key1, :unique => true

    create_table :userroles, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :userroles, [:name], :name => :userroles_name_key, :unique => true

    create_table :users, :force => true do |t|
      t.references :userstatus, :null => false
      t.references :user_incharge, :class_name => 'User', :foreing_key => 'user_incharge_id'
      t.text :login, :null => false
      t.text :passwd, :salt, :email, :homepage, :blog, :calendar, :pkcs7, :token
      t.datetime :token_expiry
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :users, [:id], :name => :users_id_idx
    add_index :users, [:login], :name => :users_login_idx
    add_index :users, [:login], :name => :users_login_key, :unique => true

    create_table :users_logs, :force => true do |t|
      t.references :user, :null => false
      t.references :old_userstatus, :class_name => 'Userstatus', :foreing_key => 'old_userstatus_id', :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :usersstatuses_comments, :force => true do |t|
      t.references :user, :userstatus, :null => false
      t.text :comments, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :userstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :userstatuses, [:name], :name => :userstatuses_name_key, :unique => true

    create_table :volumes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    add_index :volumes, [:name], :name => :volumes_name_key, :unique => true
  end

  def self.down
    drop_table :academicprograms, :academicprogramtypes, :acadvisits, :acadvisittypes, :actions, :activities, :activitygroups
    drop_table :activitytypes, :addresses, :addresstypes, :adscriptions, :adviceactivities, :articles, :articlesfiles, :articleslog
    drop_table :articlestatuses, :bookchaptertypes, :bookedition_comments, :bookedition_publishers, :bookedition_roleinbooks
    drop_table :bookeditions, :books, :booktypes, :careers, :chapterinbook_comments, :chapterinbook_roleinchapters, :chapterinbooks
    drop_table :cities, :citizenmodalities, :citizens, :conference_institutions, :conferences, :conferencescopes, :conferencetalks
    drop_table :conferencetalksfiles, :conferencetypes, :contracttypes, :controllers, :countries, :coursedurations, :coursegroups
    drop_table :coursegrouptypes, :courses, :credentials, :credittypes, :degrees, :documents, :documenttypes, :editions
    drop_table :editionstatuses, :externaluserlevels, :externalusers, :file_articles, :genericworkgroups, :genericworks, :genericworksfiles
    drop_table :genericworkslog, :genericworkstatuses, :genericworktypes, :grants, :groupmodalities, :groups, :identifications, :idtypes
    drop_table :indivadviceprograms, :indivadvices, :indivadvicetargets, :inproceedings, :instadviceactivities, :instadvices
    drop_table :instadvicetargets, :institutional_activities, :institutioncareers, :institutions, :institutiontitles, :institutiontypes
    drop_table :jobposition_logs, :jobpositioncategories, :jobpositionlevels, :jobpositionlog, :jobpositions, :jobpositiontypes
    drop_table :journal_publicationcategories, :journals, :languagelevels, :languages, :maritalstatuses, :mediatypes, :memberships
    drop_table :migratorystatuses, :modalities, :newspaperarticles, :newspapers, :people, :people_identifications, :periods
    drop_table :permissions, :plan, :prizes, :prizetypes, :probatory_documents, :probatorydoctypes, :proceedings, :professionaltitles
    drop_table :projectacadvisits, :projectarticles, :projectconferencetalks, :projectfiles, :projectfinancingsources
    drop_table :projectgenericworks, :projectinstitutions, :projectresearchareas, :projectresearchlines, :projects, :projectstatuses
    drop_table :projecttheses, :projecttypes, :publicationcategories, :publishers, :pubtorefereed, :refereedpubs, :regularcourses
    drop_table :researchareas, :researchgroupmodalities, :researchgroups, :researchlines, :reviews, :roleinbooks, :roleinchapters
    drop_table :roleinconferences, :roleinconferencetalks, :roleincourses, :roleingroups, :roleinjobpositions, :roleinjournals
    drop_table :roleinjuries, :roleinprojects, :roleinregularcourses, :roleinseminaries, :roleintheses, :roleproceedings
    drop_table :roles, :schema_info, :schoolarships, :schooling_files, :schooling_filetypes, :schoolings, :selfevaluation
    drop_table :seminaries, :seminarytypes, :sessions, :skilltypes, :sponsor_acadvisits, :states, :stimuluslevels, :stimulustypes
    drop_table :student_activities, :studentroles, :talkacceptances, :talktypes, :techproducts, :techproductstatuses
    drop_table :techproducttypes, :theses, :theses_logs, :thesis_jurors, :thesismodalities, :thesisstatuses, :titlemodalities
    drop_table :trashes, :tutorial_committees, :user_adscriptions, :user_articles, :user_cites, :user_cites_logs
    drop_table :user_conferencetalks, :user_courses, :user_credits, :user_creditsarticles, :user_creditsbookeditions
    drop_table :user_creditschapterinbooks, :user_creditsconferencetalks, :user_creditsgenericworks, :user_document_logs
    drop_table :user_documents, :user_genericworks, :user_grants, :user_groups, :user_inproceedings, :user_journals, :user_languages
    drop_table :user_newspaperarticles, :user_prizes, :user_proceedings, :user_projects, :user_regularcourses, :user_researchlines
    drop_table :user_roleingroups, :user_schoolarships, :user_seminaries, :user_skills, :user_stimulus, :user_techproducts
    drop_table :user_theses, :userconferences, :usercredits, :usercreditsarticles, :usercreditsbooks, :usercreditsconferencetalks
    drop_table :usercreditsgenericworks, :userrefereedpubs, :userresearchgroups, :userroles, :users, :users_logs
    drop_table :usersstatuses_comments, :userstatuses, :volumes
  end
end
