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

    create_table :actions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :activities, :force => true do |t|
        t.references :user, :activitytype, :null => false
      t.integer :year, :null => false
      t.integer :month
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :activitygroups, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :activitytypes, :force => true do |t|
      t.references :activitygroup, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :addresstypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :adscriptions, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.text :abbrev, :descr, :administrative_key
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :adviceactivities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :bookchaptertypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :bookedition_comments, :force => true do |t|
      t.references :user, :bookedition, :null => false
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :bookedition_publishers, :force => true do |t|
      t.references :bookedition, :publisher, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :cities, :force => true do |t|
      t.references :state, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :citizenmodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :citizens, :force => true do |t|
      t.references :user, :migratorystatus, :citizenmodality, :null => false
      t.references :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id', :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :conference_institutions, :force => true do |t|
      t.references :conference, :institution, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :conferencetalks, :force => true do |t|
      t.references :conference, :talktype, :talkacceptance, :modality, :null => false
      t.text :title, :authors, :null => false
      t.text :abstract
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :conferencetalksfiles, :force => true do |t|
      t.references :conferencetalks, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :conferencetypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :contracttypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :controllers, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :countries, :force => true do |t|
      t.text :name, :citizen, :null => false
      t.string :code, :limit => 3, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :coursedurations, :force => true do |t|
      t.integer :days, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :coursegroups, :force => true do |t|
      t.references :coursegrouptype, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth, :totalhours
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :coursegrouptypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :credittypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :degrees, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :documents, :force => true do |t|
      t.references :documenttype, :null => false
      t.text :title, :null => false
      t.date :startdate, :null => false
      t.date :enddate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :documenttypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :editions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :editionstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :externaluserlevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :genericworkgroups, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :genericworktypes, :force => true do |t|
      t.references :genericworkgroup, :null => false
      t.text :name, :null => false
      t.text :abbrev
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :grants, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :groupmodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :groups, :force => true do |t|
      t.references :parent
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :identifications, :force => true do |t|
      t.references :idtype, :null => false
      t.references :citizen_country, :class_name => 'Country', :foreign_key => 'citizen_country_id', :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :idtypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :indivadviceprograms, :force => true do |t|
      t.references :institution, :null => false
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :institutiontypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :jobposition_logs, :force => true do |t|
      t.references :user, :null => false
      t.integer :academic_years, :administrative_years
      t.text :worker_key, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :journal_publicationcategories, :force => true do |t|
      t.references :journal, :publicationcategory, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :journals, :force => true do |t|
      t.references :mediatype, :country, :null => false
      t.references :publisher
      t.text :name, :null => false
      t.text :issn, :url, :abbrev, :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :languagelevels, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :languages, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :maritalstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :mediatypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :modalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :people_identifications, :force => true do |t|
      t.references :user, :identification, :null => false
      t.text :descr, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :periods, :force => true do |t|
      t.text :title, :null => false
      t.date :startdate, :null => false
      t.date :enddate, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :permissions, :force => true do |t|
      t.references :roleingroup, :controller, :action, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :probatory_documents, :force => true do |t|
      t.references :user, :probatorydoctype, :null => false
      t.text :filename, :content_type, :null => false
      t.text :other
      t.binary :file, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :probatorydoctypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :projectacadvisits, :force => true do |t|
      t.references :project, :acadvisit, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectarticles, :force => true do |t|
      t.references :project, :article, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectconferencetalks, :force => true do |t|
      t.references :project, :conferencetalk, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectfiles, :force => true do |t|
      t.references :project, :null => false
      t.text :filename, :null => false
      t.text :filedescr
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectfinancingsources, :force => true do |t|
      t.references :project, :institution, :null => false
      t.text :other
      t.decimal :amount, :precision => 10, :scale => 2, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectgenericworks, :force => true do |t|
      t.references :project, :genericwork, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectinstitutions, :force => true do |t|
      t.references :project, :institution, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectresearchareas, :force => true do |t|
      t.references :project, :researcharea, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projectresearchlines, :force => true do |t|
      t.references :project, :researchline, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :projectstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projecttheses, :force => true do |t|
      t.references :project, :thesis, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :projecttypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :publicationcategories, :force => true do |t|
      t.text :descr
      t.string :name, :limit => 50, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :publishers, :force => true do |t|
      t.text :name, :null => false
      t.text :descr, :url
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :pubtorefereed, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :roleinchapters, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinconferences, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinconferencetalks, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleincourses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleingroups, :force => true do |t|
      t.references :group, :role, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinjobpositions, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinjournals, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinjuries, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinprojects, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinregularcourses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleinseminaries, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleintheses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roleproceedings, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :roles, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.boolean :has_group_right, :default => true, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :schooling_files, :force => true do |t|
      t.references :schooling, :null => false
      t.references :schooling_filetype, :class_name => 'Filetype', :foreing_key => 'schooling_filetype_id', :null => false
      t.text :filename, :null => false
      t.text :content_type
      t.binary :content, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :schooling_filetypes, :force => true do |t|
      t.text :name, :null => false
      t.text :descr
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :sessions, :force => true do |t|
      t.references :session
      t.text :data
      t.datetime :updated_at
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :skilltypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :studentroles, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :talkacceptances, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :talktypes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :thesisstatuses, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :titlemodalities, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :user_cites_logs, :force => true do |t|
      t.references :user, :null => false
      t.integer :total, :year, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_conferencetalks, :force => true do |t|
      t.references :user, :roleinconferencetalk, :null => false
      t.references :conferencetalk
      t.text :comment
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :user_creditsarticles, :force => true do |t|
      t.references :user, :article, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_creditsbookeditions, :force => true do |t|
      t.references :user, :bookedition, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_creditschapterinbooks, :force => true do |t|
      t.references :user, :chapterinbook, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_creditsconferencetalks, :force => true do |t|
      t.references :user, :conferencetalk, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_creditsgenericworks, :force => true do |t|
      t.references :user, :genericwork, :null => false
      t.text :other
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :user_groups, :force => true do |t|
      t.references :user, :group, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :user_schoolarships, :force => true do |t|
      t.references :schoolarship, :user, :null => false
      t.integer :startyear, :null => false
      t.integer :startmonth, :endyear, :endmonth
      t.text :descr
      t.decimal :amount, :precision => 10, :scale => 2
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :user_seminaries, :force => true do |t|
      t.references :seminary, :user, :roleinseminary, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :usercreditsbooks, :force => true do |t|
      t.references :usercredits, :books, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :usercreditsconferencetalks, :force => true do |t|
      t.references :usercredits, :conferencetalks, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :usercreditsgenericworks, :force => true do |t|
      t.references :usercredits, :genericworks, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :userrefereedpubs, :force => true do |t|
      t.references :refereedpubs, :null => false
      t.references :externaluser, :internaluser
      t.boolean :user_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :userresearchgroups, :force => true do |t|
      t.references :researchgroup, :null => false
      t.references :externaluser, :internaluser
      t.integer :year, :null => false
      t.boolean :user_is_internal
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :userroles, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

    create_table :users, :force => true do |t|
      t.references :userstatus, :null => false
      t.references :user_incharge, :class_name => 'User', :foreing_key => 'user_incharge_id'
      t.text :login, :null => false
      t.text :passwd, :salt, :email, :homepage, :blog, :calendar, :pkcs7, :token
      t.datetime :token_expiry
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end

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

    create_table :volumes, :force => true do |t|
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id'
      t.timestamps
    end
    
    create_table :trees, :force => true do |t|
      t.integer :parent_id, :pos, :lft, :rgt, :root_id
      t.text :name, :null => false
      t.references :moduser, :class_name => 'User', :foreign_key => 'moduser_id' 
      t.timestamps
    end
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
    drop_table :trees
  end
end
