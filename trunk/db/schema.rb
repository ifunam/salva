# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of ActiveRecord to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define() do

  create_table "academicprograms", :force => true do |t|
    t.integer  "institutioncareer_id",   :null => false
    t.integer  "academicprogramtype_id", :null => false
    t.integer  "year",                   :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "academicprogramtypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "academicprogramtypes", ["name"], :name => "academicprogramtypes_name_key", :unique => true

  create_table "acadvisits", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "institution_id",   :null => false
    t.integer  "country_id",       :null => false
    t.integer  "acadvisittype_id", :null => false
    t.text     "descr",            :null => false
    t.integer  "startyear",        :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.text     "place"
    t.text     "goals"
    t.text     "other"
    t.integer  "externaluser_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "acadvisittypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "acadvisittypes", ["name"], :name => "acadvisittypes_name_key", :unique => true

  create_table "actions", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "actions", ["name"], :name => "actions_name_key", :unique => true

  create_table "activities", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "activitytype_id", :null => false
    t.text     "name",            :null => false
    t.text     "descr"
    t.integer  "year",            :null => false
    t.integer  "month"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "activities", ["activitytype_id", "name", "year", "month"], :name => "activities_activitytype_id_key", :unique => true

  create_table "activitygroups", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "activitygroups", ["name"], :name => "activitygroups_name_key", :unique => true

  create_table "activitytypes", :force => true do |t|
    t.text     "name",             :null => false
    t.integer  "activitygroup_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "activitytypes", ["name"], :name => "activitytypes_name_key", :unique => true

  create_table "addresses", :force => true do |t|
    t.integer  "user_id",                           :null => false
    t.integer  "addresstype_id",                    :null => false
    t.text     "location",                          :null => false
    t.text     "pobox"
    t.integer  "country_id",                        :null => false
    t.integer  "state_id"
    t.integer  "city_id"
    t.integer  "zipcode"
    t.text     "phone"
    t.text     "fax"
    t.text     "movil"
    t.text     "other"
    t.boolean  "is_postaddress", :default => false, :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "addresses", ["user_id", "addresstype_id"], :name => "addresses_user_id_key", :unique => true

  create_table "addresstypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "addresstypes", ["name"], :name => "addresstypes_name_key", :unique => true

  create_table "adscriptions", :force => true do |t|
    t.text     "name",               :null => false
    t.text     "abbrev"
    t.text     "descr"
    t.integer  "institution_id",     :null => false
    t.text     "administrative_key"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "adscriptions", ["name", "institution_id"], :name => "adscriptions_name_key", :unique => true

  create_table "adviceactivities", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "adviceactivities", ["name"], :name => "adviceactivities_name_key", :unique => true

  create_table "articles", :force => true do |t|
    t.text     "title",            :null => false
    t.integer  "journal_id",       :null => false
    t.integer  "articlestatus_id", :null => false
    t.text     "pages"
    t.integer  "year",             :null => false
    t.integer  "month"
    t.text     "vol"
    t.text     "num"
    t.text     "authors",          :null => false
    t.text     "url"
    t.text     "pacsnum"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "articlesfiles", :force => true do |t|
    t.text     "filename",      :null => false
    t.integer  "articles_id",   :null => false
    t.text     "filedescr"
    t.binary   "content",       :null => false
    t.datetime "creationtime",  :null => false
    t.datetime "lastmodiftime", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "articlesfiles", ["filename", "articles_id"], :name => "articlesfiles_articles_id_key", :unique => true
  add_index "articlesfiles", ["articles_id"], :name => "articlesfiles_articles_idx"
  add_index "articlesfiles", ["filename"], :name => "articlesfiles_filename_idx"

  create_table "articleslog", :force => true do |t|
    t.integer  "article_id",           :null => false
    t.integer  "old_articlestatus_id", :null => false
    t.date     "changedate",           :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "articlestatuses", :force => true do |t|
    t.string "name", :limit => 50, :null => false
  end

  add_index "articlestatuses", ["name"], :name => "articlestatuses_name_key", :unique => true

  create_table "bookchaptertypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "bookchaptertypes", ["name"], :name => "bookchaptertypes_name_key", :unique => true

  create_table "bookedition_comments", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "bookedition_id", :null => false
    t.text     "comment"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "bookedition_comments", ["user_id", "bookedition_id"], :name => "bookedition_comments_user_id_key", :unique => true

  create_table "bookedition_publishers", :force => true do |t|
    t.integer  "bookedition_id", :null => false
    t.integer  "publisher_id",   :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "bookedition_publishers", ["bookedition_id", "publisher_id"], :name => "bookedition_publishers_bookedition_id_key", :unique => true

  create_table "bookedition_roleinbooks", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "bookedition_id", :null => false
    t.integer  "roleinbook_id",  :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "bookeditions", :force => true do |t|
    t.integer  "book_id",          :null => false
    t.text     "edition",          :null => false
    t.integer  "pages"
    t.text     "isbn"
    t.integer  "mediatype_id",     :null => false
    t.integer  "editionstatus_id"
    t.integer  "month"
    t.integer  "year",             :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "books", :force => true do |t|
    t.text     "title",       :null => false
    t.text     "authors",     :null => false
    t.text     "booklink"
    t.integer  "country_id",  :null => false
    t.integer  "booktype_id", :null => false
    t.text     "volume"
    t.integer  "language_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "booktypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "booktypes", ["name"], :name => "booktypes_name_key", :unique => true

  create_table "careers", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "abbrev"
    t.integer  "degree_id",  :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "chapterinbook_comments", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "chapterinbook_id", :null => false
    t.text     "comment"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "chapterinbook_comments", ["user_id", "chapterinbook_id"], :name => "chapterinbook_comments_user_id_key", :unique => true

  create_table "chapterinbook_roleinchapters", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "chapterinbook_id", :null => false
    t.integer  "roleinchapter_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "chapterinbooks", :force => true do |t|
    t.integer  "bookedition_id",     :null => false
    t.integer  "bookchaptertype_id", :null => false
    t.text     "title",              :null => false
    t.text     "pages"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "chapterinbooks", ["title"], :name => "chapterinbooks_title_idx"

  create_table "cities", :force => true do |t|
    t.integer  "state_id",   :null => false
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "cities", ["state_id", "name"], :name => "cities_state_id_key", :unique => true

  create_table "citizenmodalities", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "citizenmodalities", ["name"], :name => "citizenmodalities_name_key", :unique => true

  create_table "citizens", :force => true do |t|
    t.integer  "user_id",            :null => false
    t.integer  "citizen_country_id", :null => false
    t.integer  "migratorystatus_id", :null => false
    t.integer  "citizenmodality_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "citizens", ["user_id", "citizen_country_id"], :name => "citizens_user_id_key", :unique => true

  create_table "conference_institutions", :force => true do |t|
    t.integer  "conference_id",  :null => false
    t.integer  "institution_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "conference_institutions", ["conference_id", "institution_id"], :name => "conference_institutions_conference_id_key", :unique => true

  create_table "conferences", :force => true do |t|
    t.text     "name",                                  :null => false
    t.text     "url"
    t.integer  "month"
    t.integer  "year",                                  :null => false
    t.integer  "conferencetype_id",                     :null => false
    t.integer  "country_id",                            :null => false
    t.integer  "conferencescope_id"
    t.text     "location"
    t.boolean  "isspecialized",      :default => false, :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "conferencescopes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "conferencescopes", ["name"], :name => "conferencescopes_name_key", :unique => true

  create_table "conferencetalks", :force => true do |t|
    t.text     "title",             :null => false
    t.text     "authors",           :null => false
    t.text     "abstract"
    t.integer  "conference_id",     :null => false
    t.integer  "talktype_id",       :null => false
    t.integer  "talkacceptance_id", :null => false
    t.integer  "modality_id",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "conferencetalks", ["title", "authors", "conference_id", "talktype_id"], :name => "conferencetalks_conference_id_key", :unique => true

  create_table "conferencetalksfiles", :force => true do |t|
    t.text     "filename",           :null => false
    t.integer  "conferencetalks_id", :null => false
    t.text     "filedescr"
    t.binary   "content",            :null => false
    t.datetime "creationtime",       :null => false
    t.datetime "lastmodiftime",      :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "conferencetalksfiles", ["filename", "conferencetalks_id"], :name => "conferencetalksfiles_conferencetalks_id_key", :unique => true
  add_index "conferencetalksfiles", ["conferencetalks_id"], :name => "conferencetalksfiles_conferencetalks_idx"
  add_index "conferencetalksfiles", ["filename"], :name => "conferencetalksfiles_filename_idx"

  create_table "conferencetypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "conferencetypes", ["name"], :name => "conferencetypes_name_key", :unique => true

  create_table "contracttypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "contracttypes", ["name"], :name => "contracttypes_name_key", :unique => true

  create_table "controllers", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "controllers", ["name"], :name => "controllers_name_key", :unique => true

  create_table "countries", :force => true do |t|
    t.text   "name",                 :null => false
    t.text   "citizen",              :null => false
    t.string "code",    :limit => 3, :null => false
  end

  add_index "countries", ["code"], :name => "countries_code_key", :unique => true
  add_index "countries", ["name"], :name => "countries_name_key", :unique => true

  create_table "coursedurations", :force => true do |t|
    t.text    "name", :null => false
    t.integer "days", :null => false
  end

  add_index "coursedurations", ["name"], :name => "coursedurations_name_key", :unique => true

  create_table "coursegroups", :force => true do |t|
    t.text    "name",               :null => false
    t.integer "coursegrouptype_id", :null => false
    t.integer "startyear",          :null => false
    t.integer "startmonth"
    t.integer "endyear"
    t.integer "endmonth"
    t.integer "totalhours"
  end

  add_index "coursegroups", ["name", "coursegrouptype_id", "startyear", "startmonth", "endyear", "endmonth"], :name => "coursegroups_name_key", :unique => true

  create_table "coursegrouptypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "coursegrouptypes", ["name"], :name => "coursegrouptypes_name_key", :unique => true

  create_table "courses", :force => true do |t|
    t.text    "name",              :null => false
    t.integer "country_id",        :null => false
    t.integer "institution_id"
    t.integer "coursegroup_id"
    t.integer "courseduration_id", :null => false
    t.integer "modality_id",       :null => false
    t.integer "startyear",         :null => false
    t.integer "startmonth"
    t.integer "endyear"
    t.integer "endmonth"
    t.integer "hoursxweek"
    t.text    "location"
    t.integer "totalhours"
  end

  create_table "credentials", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "abbrev"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "credentials", ["name"], :name => "credentials_name_key", :unique => true

  create_table "credittypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "credittypes", ["name"], :name => "credittypes_name_key", :unique => true

  create_table "degrees", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "degrees", ["name"], :name => "degrees_name_key", :unique => true

  create_table "documents", :force => true do |t|
    t.integer  "documenttype_id", :null => false
    t.text     "title",           :null => false
    t.date     "startdate",       :null => false
    t.date     "enddate",         :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "documents", ["documenttype_id", "title"], :name => "documents_documenttype_id_key", :unique => true

  create_table "documenttypes", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "documenttypes", ["name"], :name => "documenttypes_name_key", :unique => true

  create_table "editions", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "editions", ["name"], :name => "editions_name_key", :unique => true

  create_table "editionstatuses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "editionstatuses", ["name"], :name => "editionstatuses_name_key", :unique => true

  create_table "externaluserlevels", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "externaluserlevels", ["name"], :name => "externaluserlevels_name_key", :unique => true

  create_table "externalusers", :force => true do |t|
    t.text    "firstname",            :null => false
    t.text    "lastname1",            :null => false
    t.text    "lastname2"
    t.integer "institution_id"
    t.integer "externaluserlevel_id"
    t.integer "degree_id"
  end

  create_table "file_articles", :force => true do |t|
    t.integer  "article_id",    :null => false
    t.text     "filename",      :null => false
    t.text     "conten_type"
    t.binary   "content",       :null => false
    t.datetime "creationtime",  :null => false
    t.datetime "lastmodiftime", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "file_articles", ["article_id", "filename"], :name => "file_articles_article_id_key", :unique => true

  create_table "genericworkgroups", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "genericworkgroups", ["name"], :name => "genericworkgroups_name_key", :unique => true

  create_table "genericworks", :force => true do |t|
    t.text     "title",                :null => false
    t.text     "authors",              :null => false
    t.integer  "genericworktype_id",   :null => false
    t.integer  "genericworkstatus_id", :null => false
    t.integer  "institution_id"
    t.integer  "publisher_id"
    t.text     "reference"
    t.text     "vol"
    t.text     "pages"
    t.integer  "year",                 :null => false
    t.integer  "month"
    t.text     "isbn_issn"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "genericworksfiles", :force => true do |t|
    t.text     "filename",        :null => false
    t.integer  "genericworks_id", :null => false
    t.text     "filedescr"
    t.binary   "content",         :null => false
    t.datetime "creationtime",    :null => false
    t.datetime "lastmodiftime",   :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "genericworksfiles", ["filename"], :name => "genericworksfiles_filename_idx"
  add_index "genericworksfiles", ["filename", "genericworks_id"], :name => "genericworksfiles_genericworks_id_key", :unique => true
  add_index "genericworksfiles", ["genericworks_id"], :name => "genericworksfiles_genericworks_idx"

  create_table "genericworkslog", :force => true do |t|
    t.integer  "genericwork_id",           :null => false
    t.integer  "old_genericworkstatus_id", :null => false
    t.date     "changedate",               :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "genericworkstatuses", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "genericworkstatuses", ["name"], :name => "genericworkstatuses_name_key", :unique => true

  create_table "genericworktypes", :force => true do |t|
    t.text     "name",                :null => false
    t.text     "abbrev"
    t.integer  "genericworkgroup_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "genericworktypes", ["name", "genericworkgroup_id"], :name => "genericworktypes_name_key", :unique => true

  create_table "grants", :force => true do |t|
    t.text    "name",           :null => false
    t.integer "institution_id", :null => false
    t.integer "moduser_id"
  end

  add_index "grants", ["name", "institution_id"], :name => "grants_name_key", :unique => true

  create_table "groupmodalities", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "groupmodalities", ["name"], :name => "groupmodalities_name_key", :unique => true

  create_table "groups", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.integer  "parent_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "groups", ["name", "parent_id"], :name => "groups_name_key", :unique => true

  create_table "identifications", :force => true do |t|
    t.integer  "idtype_id",          :null => false
    t.integer  "citizen_country_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "identifications", ["idtype_id", "citizen_country_id"], :name => "identifications_idtype_id_key", :unique => true

  create_table "idtypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "idtypes", ["name"], :name => "idtypes_name_key", :unique => true

  create_table "indivadviceprograms", :force => true do |t|
    t.text    "name",           :null => false
    t.text    "descr"
    t.integer "institution_id", :null => false
  end

  add_index "indivadviceprograms", ["name"], :name => "indivadviceprograms_name_key", :unique => true

  create_table "indivadvices", :force => true do |t|
    t.integer  "user_id",               :null => false
    t.text     "indivname"
    t.integer  "indivuser_id"
    t.integer  "institution_id"
    t.integer  "indivadvicetarget_id",  :null => false
    t.integer  "indivadviceprogram_id"
    t.integer  "degree_id"
    t.integer  "startyear",             :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.integer  "hours",                 :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "indivadvicetargets", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "indivadvicetargets", ["name"], :name => "indivadvicetargets_name_key", :unique => true

  create_table "inproceedings", :force => true do |t|
    t.integer  "proceeding_id", :null => false
    t.text     "title",         :null => false
    t.text     "authors",       :null => false
    t.text     "pages"
    t.text     "comment"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "instadviceactivities", :force => true do |t|
    t.integer  "instadvice_id",     :null => false
    t.integer  "adviceactivity_id", :null => false
    t.text     "duration"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "instadviceactivities", ["instadvice_id", "adviceactivity_id"], :name => "instadviceactivities_instadvice_id_key", :unique => true

  create_table "instadvices", :force => true do |t|
    t.text     "title",               :null => false
    t.integer  "user_id",             :null => false
    t.integer  "institution_id",      :null => false
    t.integer  "instadvicetarget_id", :null => false
    t.text     "other"
    t.integer  "year",                :null => false
    t.integer  "month"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "instadvicetargets", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "instadvicetargets", ["name"], :name => "instadvicetargets_name_key", :unique => true

  create_table "institutional_activities", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.text     "descr",          :null => false
    t.integer  "institution_id", :null => false
    t.integer  "startmonth"
    t.integer  "startyear",      :null => false
    t.integer  "endmonth"
    t.integer  "endyear"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "institutioncareers", :force => true do |t|
    t.integer  "institution_id", :null => false
    t.integer  "career_id",      :null => false
    t.text     "url"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "institutioncareers", ["institution_id", "career_id"], :name => "institutioncareers_institution_id_key", :unique => true

  create_table "institutions", :force => true do |t|
    t.integer  "institutiontype_id",  :null => false
    t.text     "name",                :null => false
    t.text     "url"
    t.text     "abbrev"
    t.integer  "institution_id"
    t.integer  "institutiontitle_id", :null => false
    t.text     "addr"
    t.integer  "country_id",          :null => false
    t.integer  "state_id"
    t.integer  "city_id"
    t.text     "zipcode"
    t.text     "phone"
    t.text     "fax"
    t.text     "administrative_key"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "institutiontitles", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "institutiontitles", ["name"], :name => "institutiontitles_name_key", :unique => true

  create_table "institutiontypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "institutiontypes", ["name"], :name => "institutiontypes_name_key", :unique => true

  create_table "jobposition_logs", :force => true do |t|
    t.integer  "user_id",              :null => false
    t.text     "worker_key",           :null => false
    t.integer  "academic_years"
    t.integer  "administrative_years"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "jobposition_logs", ["user_id"], :name => "jobposition_logs_user_id_key", :unique => true
  add_index "jobposition_logs", ["worker_key"], :name => "jobposition_logs_worker_key_key", :unique => true

  create_table "jobpositioncategories", :force => true do |t|
    t.integer "jobpositiontype_id",   :null => false
    t.integer "roleinjobposition_id", :null => false
    t.integer "jobpositionlevel_id"
    t.text    "administrative_key"
  end

  create_table "jobpositionlevels", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "jobpositionlevels", ["name"], :name => "jobpositionlevels_name_key", :unique => true

  create_table "jobpositionlog", :force => true do |t|
    t.integer  "user_id",                    :null => false
    t.integer  "old_jobpositioncategory_id"
    t.integer  "old_contracttype_id"
    t.integer  "institution_id",             :null => false
    t.integer  "startyear",                  :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.text     "old_descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "jobpositions", :force => true do |t|
    t.integer  "user_id",                :null => false
    t.integer  "jobpositioncategory_id"
    t.integer  "contracttype_id"
    t.integer  "institution_id",         :null => false
    t.text     "descr"
    t.integer  "startmonth"
    t.integer  "startyear",              :null => false
    t.integer  "endmonth"
    t.integer  "endyear"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "jobpositiontypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "jobpositiontypes", ["name"], :name => "jobpositiontypes_name_key", :unique => true

  create_table "journal_publicationcategories", :force => true do |t|
    t.integer  "journal_id",             :null => false
    t.integer  "publicationcategory_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "journal_publicationcategories", ["journal_id", "publicationcategory_id"], :name => "journal_publicationcategories_journal_id_key", :unique => true

  create_table "journals", :force => true do |t|
    t.text     "name",         :null => false
    t.text     "issn"
    t.text     "url"
    t.text     "abbrev"
    t.text     "other"
    t.integer  "mediatype_id", :null => false
    t.integer  "publisher_id"
    t.integer  "country_id",   :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "journals", ["name", "issn", "mediatype_id", "country_id"], :name => "journals_name_key", :unique => true

  create_table "languagelevels", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "languagelevels", ["name"], :name => "languagelevels_name_key", :unique => true

  create_table "languages", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "languages", ["name"], :name => "languages_name_key", :unique => true

  create_table "maritalstatuses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "maritalstatuses", ["name"], :name => "maritalstatuses_name_key", :unique => true

  create_table "mediatypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "mediatypes", ["name"], :name => "mediatypes_name_key", :unique => true

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "institution_id", :null => false
    t.text     "descr"
    t.integer  "startyear"
    t.integer  "endyear"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "migratorystatuses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "migratorystatuses", ["name"], :name => "migratorystatuses_name_key", :unique => true

  create_table "modalities", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "modalities", ["name"], :name => "modalities_name_key", :unique => true

  create_table "newspaperarticles", :force => true do |t|
    t.text     "title",        :null => false
    t.text     "authors",      :null => false
    t.integer  "newspaper_id", :null => false
    t.date     "newsdate",     :null => false
    t.text     "pages"
    t.text     "url"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "newspapers", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "url"
    t.integer  "country_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "newspapers", ["name"], :name => "newspapers_name_key", :unique => true

  create_table "people", :id => false, :force => true do |t|
    t.integer  "user_id",            :null => false
    t.text     "firstname",          :null => false
    t.text     "lastname1",          :null => false
    t.text     "lastname2"
    t.boolean  "gender",             :null => false
    t.integer  "maritalstatus_id"
    t.date     "dateofbirth",        :null => false
    t.integer  "country_id",         :null => false
    t.integer  "state_id"
    t.integer  "city_id"
    t.text     "photo_filename"
    t.text     "photo_content_type"
    t.binary   "photo"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "people", ["firstname"], :name => "people_firstname_idx"
  add_index "people", ["lastname1"], :name => "people_lastname1_idx"
  add_index "people", ["lastname2"], :name => "people_lastname2_idx"

  create_table "people_identifications", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.integer  "identification_id", :null => false
    t.text     "descr",             :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "people_identifications", ["user_id", "identification_id"], :name => "people_identifications_user_id_key", :unique => true

  create_table "periods", :force => true do |t|
    t.text     "title",      :null => false
    t.date     "startdate",  :null => false
    t.date     "enddate",    :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "periods", ["title"], :name => "periods_title_key", :unique => true
  add_index "periods", ["title", "startdate", "enddate"], :name => "periods_title_key1", :unique => true

  create_table "permissions", :force => true do |t|
    t.integer  "roleingroup_id", :null => false
    t.integer  "controller_id",  :null => false
    t.integer  "action_id",      :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "permissions", ["roleingroup_id", "controller_id", "action_id"], :name => "permissions_roleingroup_id_key", :unique => true

  create_table "plan", :force => true do |t|
    t.integer "user_id",      :null => false
    t.text    "plan",         :null => false
    t.binary  "extendedinfo"
    t.integer "year",         :null => false
  end

  create_table "prizes", :force => true do |t|
    t.text     "name",           :null => false
    t.integer  "prizetype_id",   :null => false
    t.integer  "institution_id", :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "prizetypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "prizetypes", ["name"], :name => "prizetypes_name_key", :unique => true

  create_table "probatory_documents", :force => true do |t|
    t.integer  "user_id",             :null => false
    t.integer  "probatorydoctype_id", :null => false
    t.text     "filename",            :null => false
    t.text     "content_type",        :null => false
    t.binary   "file",                :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "probatory_documents", ["user_id", "probatorydoctype_id"], :name => "probatory_documents_user_id_key", :unique => true

  create_table "probatorydoctypes", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "probatorydoctypes", ["name"], :name => "probatorydoctypes_name_key", :unique => true

  create_table "proceedings", :force => true do |t|
    t.integer  "conference_id",                   :null => false
    t.text     "title",                           :null => false
    t.integer  "year"
    t.integer  "publisher_id"
    t.boolean  "isrefereed",    :default => true, :null => false
    t.text     "volume"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "professionaltitles", :force => true do |t|
    t.integer  "schooling_id",     :null => false
    t.integer  "titlemodality_id", :null => false
    t.text     "professionalid"
    t.integer  "year"
    t.text     "thesistitle"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "professionaltitles", ["schooling_id"], :name => "professionaltitles_schooling_id_key", :unique => true

  create_table "projectacadvisits", :force => true do |t|
    t.integer "project_id",   :null => false
    t.integer "acadvisit_id", :null => false
  end

  add_index "projectacadvisits", ["project_id", "acadvisit_id"], :name => "projectacadvisits_project_id_key", :unique => true

  create_table "projectarticles", :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "article_id", :null => false
  end

  add_index "projectarticles", ["project_id", "article_id"], :name => "projectarticles_project_id_key", :unique => true

  create_table "projectconferencetalks", :force => true do |t|
    t.integer "project_id",        :null => false
    t.integer "conferencetalk_id", :null => false
  end

  add_index "projectconferencetalks", ["project_id", "conferencetalk_id"], :name => "projectconferencetalks_project_id_key", :unique => true

  create_table "projectfiles", :force => true do |t|
    t.integer  "project_id",    :null => false
    t.text     "filename",      :null => false
    t.text     "filedescr"
    t.binary   "content",       :null => false
    t.datetime "creationtime",  :null => false
    t.datetime "lastmodiftime", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "projectfiles", ["project_id", "filename"], :name => "projectfiles_project_id_key", :unique => true

  create_table "projectfinancingsources", :force => true do |t|
    t.integer "project_id",                                    :null => false
    t.integer "institution_id",                                :null => false
    t.decimal "amount",         :precision => 10, :scale => 2, :null => false
    t.text    "other"
  end

  add_index "projectfinancingsources", ["project_id", "institution_id"], :name => "projectfinancingsources_project_id_key", :unique => true

  create_table "projectgenericworks", :force => true do |t|
    t.integer "project_id",     :null => false
    t.integer "genericwork_id", :null => false
  end

  add_index "projectgenericworks", ["project_id", "genericwork_id"], :name => "projectgenericworks_project_id_key", :unique => true

  create_table "projectinstitutions", :force => true do |t|
    t.integer "project_id",     :null => false
    t.integer "institution_id", :null => false
    t.text    "other"
  end

  add_index "projectinstitutions", ["project_id", "institution_id"], :name => "projectinstitutions_project_id_key", :unique => true

  create_table "projectresearchareas", :force => true do |t|
    t.integer "project_id",      :null => false
    t.integer "researcharea_id", :null => false
    t.text    "other"
  end

  add_index "projectresearchareas", ["project_id", "researcharea_id"], :name => "projectresearchareas_project_id_key", :unique => true

  create_table "projectresearchlines", :force => true do |t|
    t.integer "project_id",      :null => false
    t.integer "researchline_id", :null => false
    t.text    "other"
  end

  add_index "projectresearchlines", ["project_id", "researchline_id"], :name => "projectresearchlines_project_id_key", :unique => true

  create_table "projects", :force => true do |t|
    t.text     "name",             :null => false
    t.text     "responsible",      :null => false
    t.text     "descr",            :null => false
    t.integer  "projecttype_id",   :null => false
    t.integer  "projectstatus_id", :null => false
    t.integer  "project_id"
    t.text     "abstract"
    t.text     "abbrev"
    t.integer  "startyear",        :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.text     "url"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "projects", ["descr"], :name => "projects_descr_idx"
  add_index "projects", ["name"], :name => "projects_name_idx"

  create_table "projectstatuses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "projectstatuses", ["name"], :name => "projectstatuses_name_key", :unique => true

  create_table "projecttheses", :force => true do |t|
    t.integer "project_id", :null => false
    t.integer "thesis_id",  :null => false
  end

  add_index "projecttheses", ["project_id", "thesis_id"], :name => "projecttheses_project_id_key", :unique => true

  create_table "projecttypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "projecttypes", ["name"], :name => "projecttypes_name_key", :unique => true

  create_table "publicationcategories", :force => true do |t|
    t.string   "name",       :limit => 50, :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "publicationcategories", ["name"], :name => "publicationcategories_name_key", :unique => true

  create_table "publishers", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.text     "url"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "publishers", ["name"], :name => "publishers_name_key", :unique => true

  create_table "pubtorefereed", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "pubtorefereed", ["name"], :name => "pubtorefereed_name_key", :unique => true

  create_table "refereedpubs", :force => true do |t|
    t.text    "title",            :null => false
    t.integer "pubtorefereed_id", :null => false
    t.integer "institution_id",   :null => false
    t.integer "moduser_id"
  end

  create_table "regularcourses", :force => true do |t|
    t.text     "title",              :null => false
    t.integer  "academicprogram_id"
    t.integer  "modality_id",        :null => false
    t.integer  "semester"
    t.integer  "credits"
    t.text     "administrative_key"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "researchareas", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "researchareas", ["name"], :name => "researchareas_name_key", :unique => true

  create_table "researchgroupmodalities", :force => true do |t|
    t.integer "groupmodality_id"
    t.integer "researchgroup_id", :null => false
    t.integer "adscription_id"
  end

  create_table "researchgroups", :force => true do |t|
    t.text    "name",       :null => false
    t.text    "descr"
    t.integer "moduser_id"
  end

  add_index "researchgroups", ["name"], :name => "researchgroups_name_key", :unique => true

  create_table "researchlines", :force => true do |t|
    t.text     "name",            :null => false
    t.text     "descr"
    t.integer  "researcharea_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "researchlines", ["name", "researcharea_id"], :name => "researchlines_name_key", :unique => true

  create_table "reviews", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.text     "authors",                   :null => false
    t.text     "title",                     :null => false
    t.text     "published_on",              :null => false
    t.text     "reviewed_work_title",       :null => false
    t.text     "reviewed_work_publication"
    t.integer  "year",                      :null => false
    t.integer  "month"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "roleinbooks", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinbooks", ["name"], :name => "roleinbooks_name_key", :unique => true

  create_table "roleinchapters", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinchapters", ["name"], :name => "roleinchapters_name_key", :unique => true

  create_table "roleinconferences", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinconferences", ["name"], :name => "roleinconferences_name_key", :unique => true

  create_table "roleinconferencetalks", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinconferencetalks", ["name"], :name => "roleinconferencetalks_name_key", :unique => true

  create_table "roleincourses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleincourses", ["name"], :name => "roleincourses_name_key", :unique => true

  create_table "roleingroups", :force => true do |t|
    t.integer  "group_id",   :default => 1, :null => false
    t.integer  "role_id",                   :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleingroups", ["group_id", "role_id"], :name => "roleingroups_group_id_key", :unique => true

  create_table "roleinjobpositions", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinjobpositions", ["name"], :name => "roleinjobpositions_name_key", :unique => true

  create_table "roleinjournals", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleinjournals", ["name"], :name => "roleinjournals_name_key", :unique => true

  create_table "roleinjuries", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleinjuries", ["name"], :name => "roleinjuries_name_key", :unique => true

  create_table "roleinprojects", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinprojects", ["name"], :name => "roleinprojects_name_key", :unique => true

  create_table "roleinregularcourses", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleinregularcourses", ["name"], :name => "roleinregularcourses_name_key", :unique => true

  create_table "roleinseminaries", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "roleinseminaries", ["name"], :name => "roleinseminaries_name_key", :unique => true

  create_table "roleintheses", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleintheses", ["name"], :name => "roleintheses_name_key", :unique => true

  create_table "roleproceedings", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roleproceedings", ["name"], :name => "roleproceedings_name_key", :unique => true

  create_table "roles", :force => true do |t|
    t.text     "name",                              :null => false
    t.boolean  "has_group_right", :default => true, :null => false
    t.text     "descr"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "roles", ["name"], :name => "roles_name_key", :unique => true

  create_table "schoolarships", :force => true do |t|
    t.text     "name",           :null => false
    t.integer  "institution_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "schoolarships", ["name", "institution_id"], :name => "schoolarships_name_key", :unique => true

  create_table "schooling_files", :force => true do |t|
    t.integer  "schooling_id",          :null => false
    t.integer  "schooling_filetype_id", :null => false
    t.text     "filename",              :null => false
    t.text     "content_type"
    t.binary   "content",               :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "schooling_files", ["schooling_id", "schooling_filetype_id"], :name => "schooling_files_schooling_id_key", :unique => true

  create_table "schooling_filetypes", :force => true do |t|
    t.text     "name",       :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "schooling_filetypes", ["name"], :name => "schooling_filetypes_name_key", :unique => true

  create_table "schoolings", :force => true do |t|
    t.integer  "user_id",                                 :null => false
    t.integer  "institutioncareer_id",                    :null => false
    t.integer  "startyear",                               :null => false
    t.integer  "endyear"
    t.text     "studentid"
    t.integer  "credits"
    t.float    "average"
    t.boolean  "is_studying_this",     :default => false, :null => false
    t.boolean  "is_titleholder",       :default => false, :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "schoolings", ["user_id", "institutioncareer_id"], :name => "schoolings_user_id_key", :unique => true

  create_table "selfevaluation", :force => true do |t|
    t.integer "user_id", :null => false
    t.text    "plan",    :null => false
    t.integer "year",    :null => false
  end

  create_table "seminaries", :force => true do |t|
    t.text     "title",           :null => false
    t.integer  "seminarytype_id", :null => false
    t.text     "url"
    t.integer  "month"
    t.integer  "year",            :null => false
    t.integer  "institution_id",  :null => false
    t.text     "auditorium"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "seminarytypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "seminarytypes", ["name"], :name => "seminarytypes_name_key", :unique => true

  create_table "sessions", :force => true do |t|
    t.string   "session_id"
    t.text     "data"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "sessions_session_id_index"

  create_table "skilltypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "skilltypes", ["name"], :name => "skilltypes_name_key", :unique => true

  create_table "sponsor_acadvisits", :force => true do |t|
    t.integer  "acadvisit_id",                                  :null => false
    t.integer  "institution_id",                                :null => false
    t.decimal  "amount",         :precision => 10, :scale => 2, :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "states", :force => true do |t|
    t.integer  "country_id", :null => false
    t.text     "name",       :null => false
    t.text     "code"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "states", ["name"], :name => "states_name_key", :unique => true

  create_table "stimuluslevels", :force => true do |t|
    t.text    "name",            :null => false
    t.integer "stimulustype_id", :null => false
  end

  create_table "stimulustypes", :force => true do |t|
    t.text    "name",           :null => false
    t.text    "descr"
    t.integer "institution_id", :null => false
  end

  create_table "student_activities", :force => true do |t|
    t.integer  "user_id"
    t.integer  "schooling_id"
    t.integer  "studentroles_id"
    t.boolean  "tutor_is_internal"
    t.integer  "tutor_user_id"
    t.integer  "tutor_externaluser_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "student_activities", ["user_id", "tutor_user_id"], :name => "student_activities_user_id_key", :unique => true
  add_index "student_activities", ["user_id", "tutor_externaluser_id"], :name => "student_activities_user_id_key1", :unique => true

  create_table "studentroles", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "studentroles", ["name"], :name => "studentroles_name_key", :unique => true

  create_table "talkacceptances", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "talkacceptances", ["name"], :name => "talkacceptances_name_key", :unique => true

  create_table "talktypes", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "talktypes", ["name"], :name => "talktypes_name_key", :unique => true

  create_table "techproducts", :force => true do |t|
    t.text     "title",                :null => false
    t.integer  "techproducttype_id",   :null => false
    t.text     "authors",              :null => false
    t.text     "descr"
    t.integer  "institution_id"
    t.integer  "techproductstatus_id", :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "techproductstatuses", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "techproductstatuses", ["name"], :name => "techproductstatuses_name_key", :unique => true

  create_table "techproducttypes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "theses", :force => true do |t|
    t.text     "title",                :null => false
    t.text     "authors",              :null => false
    t.integer  "institutioncareer_id", :null => false
    t.integer  "thesisstatus_id",      :null => false
    t.integer  "thesismodality_id",    :null => false
    t.integer  "startyear",            :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "theses_logs", :force => true do |t|
    t.integer  "thesis_id",           :null => false
    t.integer  "old_thesisstatus_id", :null => false
    t.integer  "startyear",           :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "thesis_jurors", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "thesis_id",     :null => false
    t.integer  "roleinjury_id", :null => false
    t.integer  "year",          :null => false
    t.integer  "month"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "thesismodalities", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "thesismodalities", ["name"], :name => "thesismodalities_name_key", :unique => true

  create_table "thesisstatuses", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "thesisstatuses", ["name"], :name => "thesisstatuses_name_key", :unique => true

  create_table "titlemodalities", :force => true do |t|
    t.text "name", :null => false
  end

  add_index "titlemodalities", ["name"], :name => "titlemodalities_name_key", :unique => true

  create_table "tutorial_committees", :force => true do |t|
    t.integer  "user_id",              :null => false
    t.text     "studentname",          :null => false
    t.text     "descr"
    t.integer  "degree_id",            :null => false
    t.integer  "institutioncareer_id", :null => false
    t.integer  "year",                 :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_adscriptions", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "jobposition_id", :null => false
    t.integer  "adscription_id", :null => false
    t.text     "name"
    t.text     "descr"
    t.integer  "startmonth"
    t.integer  "startyear",      :null => false
    t.integer  "endmonth"
    t.integer  "endyear"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_articles", :force => true do |t|
    t.integer  "user_id",                        :null => false
    t.integer  "article_id",                     :null => false
    t.boolean  "ismainauthor", :default => true, :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_cites", :force => true do |t|
    t.integer  "user_id",     :null => false
    t.text     "author_name", :null => false
    t.integer  "total",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_cites", ["user_id"], :name => "user_cites_user_id_key", :unique => true

  create_table "user_cites_logs", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "total",      :null => false
    t.integer  "year",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_cites_logs", ["user_id", "year"], :name => "user_cites_logs_user_id_key", :unique => true

  create_table "user_conferencetalks", :force => true do |t|
    t.integer  "user_id",                 :null => false
    t.integer  "conferencetalk_id"
    t.integer  "roleinconferencetalk_id", :null => false
    t.text     "comment"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_conferencetalks", ["user_id", "conferencetalk_id", "roleinconferencetalk_id"], :name => "user_conferencetalks_user_id_key", :unique => true

  create_table "user_courses", :force => true do |t|
    t.integer "user_id",         :null => false
    t.integer "course_id",       :null => false
    t.integer "roleincourse_id", :null => false
    t.text    "other"
  end

  create_table "user_credits", :force => true do |t|
    t.integer "user_id"
    t.integer "credittype_id", :null => false
    t.text    "descr",         :null => false
    t.text    "other"
    t.integer "year",          :null => false
    t.integer "month"
  end

  add_index "user_credits", ["user_id", "credittype_id", "descr", "year"], :name => "user_credits_user_id_key", :unique => true

  create_table "user_creditsarticles", :force => true do |t|
    t.integer "user_id",    :null => false
    t.integer "article_id", :null => false
    t.text    "other"
  end

  add_index "user_creditsarticles", ["user_id", "article_id"], :name => "user_creditsarticles_user_id_key", :unique => true

  create_table "user_creditsbookeditions", :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "bookedition_id", :null => false
    t.text    "other"
  end

  add_index "user_creditsbookeditions", ["user_id", "bookedition_id"], :name => "user_creditsbookeditions_user_id_key", :unique => true

  create_table "user_creditschapterinbooks", :force => true do |t|
    t.integer "user_id",          :null => false
    t.integer "chapterinbook_id", :null => false
    t.text    "other"
  end

  add_index "user_creditschapterinbooks", ["user_id", "chapterinbook_id"], :name => "user_creditschapterinbooks_user_id_key", :unique => true

  create_table "user_creditsconferencetalks", :force => true do |t|
    t.integer "user_id",           :null => false
    t.integer "conferencetalk_id", :null => false
    t.text    "other"
  end

  add_index "user_creditsconferencetalks", ["user_id", "conferencetalk_id"], :name => "user_creditsconferencetalks_user_id_key", :unique => true

  create_table "user_creditsgenericworks", :force => true do |t|
    t.integer "user_id",        :null => false
    t.integer "genericwork_id", :null => false
    t.text    "other"
  end

  add_index "user_creditsgenericworks", ["user_id", "genericwork_id"], :name => "user_creditsgenericworks_user_id_key", :unique => true

  create_table "user_document_logs", :force => true do |t|
    t.integer "user_document_id", :null => false
    t.integer "user_id",          :null => false
    t.text    "prev_ip_address",  :null => false
    t.boolean "prev_status",      :null => false
  end

  create_table "user_documents", :force => true do |t|
    t.integer  "user_id",                             :null => false
    t.integer  "document_id",                         :null => false
    t.integer  "user_incharge_id"
    t.boolean  "status",           :default => false, :null => false
    t.binary   "file",                                :null => false
    t.text     "filename",                            :null => false
    t.text     "content_type",                        :null => false
    t.text     "ip_address",                          :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_documents", ["user_id", "document_id"], :name => "user_documents_user_id_key", :unique => true

  create_table "user_genericworks", :force => true do |t|
    t.integer  "genericwork_id", :null => false
    t.integer  "user_id",        :null => false
    t.integer  "userrole_id",    :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_grants", :force => true do |t|
    t.integer "grant_id",   :null => false
    t.integer "user_id",    :null => false
    t.text    "descr"
    t.integer "startyear",  :null => false
    t.integer "startmonth"
    t.integer "endyear"
    t.integer "endmonth"
  end

  add_index "user_grants", ["grant_id", "user_id", "startyear", "startmonth"], :name => "user_grants_grant_id_key", :unique => true

  create_table "user_groups", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "group_id",   :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_groups", ["user_id", "group_id"], :name => "user_groups_user_id_key", :unique => true

  create_table "user_inproceedings", :force => true do |t|
    t.integer  "inproceeding_id",                   :null => false
    t.integer  "user_id",                           :null => false
    t.boolean  "ismainauthor",    :default => true, :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_journals", :force => true do |t|
    t.integer  "user_id",          :null => false
    t.integer  "journal_id",       :null => false
    t.integer  "roleinjournal_id", :null => false
    t.integer  "startyear",        :null => false
    t.integer  "startmonth"
    t.integer  "endyear"
    t.integer  "endmonth"
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_languages", :force => true do |t|
    t.integer  "user_id",                  :null => false
    t.integer  "language_id",              :null => false
    t.integer  "spoken_languagelevel_id",  :null => false
    t.integer  "written_languagelevel_id", :null => false
    t.integer  "institution_id",           :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_languages", ["user_id", "language_id", "institution_id"], :name => "user_languages_language_id_key", :unique => true

  create_table "user_newspaperarticles", :force => true do |t|
    t.integer  "user_id",                               :null => false
    t.integer  "newspaperarticle_id",                   :null => false
    t.boolean  "ismainauthor",        :default => true, :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_prizes", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "prize_id",   :null => false
    t.integer  "year",       :null => false
    t.integer  "month"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_proceedings", :force => true do |t|
    t.integer  "proceeding_id",     :null => false
    t.integer  "user_id",           :null => false
    t.integer  "roleproceeding_id", :null => false
    t.text     "comment"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_proceedings", ["proceeding_id", "user_id", "roleproceeding_id"], :name => "user_proceedings_proceeding_id_key", :unique => true

  create_table "user_projects", :force => true do |t|
    t.integer  "project_id",       :null => false
    t.integer  "user_id",          :null => false
    t.integer  "roleinproject_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_projects", ["project_id", "user_id", "roleinproject_id"], :name => "user_projects_project_id_key", :unique => true

  create_table "user_regularcourses", :force => true do |t|
    t.integer  "user_id",                :null => false
    t.integer  "regularcourse_id",       :null => false
    t.integer  "period_id",              :null => false
    t.integer  "roleinregularcourse_id", :null => false
    t.integer  "hoursxweek"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_researchlines", :force => true do |t|
    t.integer  "user_id",         :null => false
    t.integer  "researchline_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_roleingroups", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "roleingroup_id", :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_roleingroups", ["user_id", "roleingroup_id"], :name => "user_roleingroups_user_id_key", :unique => true

  create_table "user_schoolarships", :force => true do |t|
    t.integer "schoolarship_id",                                :null => false
    t.integer "user_id",                                        :null => false
    t.text    "descr"
    t.integer "startyear",                                      :null => false
    t.integer "startmonth"
    t.integer "endyear"
    t.integer "endmonth"
    t.decimal "amount",          :precision => 10, :scale => 2
  end

  add_index "user_schoolarships", ["schoolarship_id", "user_id", "startyear", "startmonth"], :name => "user_schoolarships_schoolarship_id_key", :unique => true

  create_table "user_seminaries", :force => true do |t|
    t.integer  "seminary_id",       :null => false
    t.integer  "user_id",           :null => false
    t.integer  "roleinseminary_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_seminaries", ["seminary_id", "user_id", "roleinseminary_id"], :name => "user_seminaries_user_id_key", :unique => true

  create_table "user_skills", :force => true do |t|
    t.integer  "user_id",      :null => false
    t.integer  "skilltype_id", :null => false
    t.text     "descr"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "user_stimulus", :force => true do |t|
    t.integer "user_id",          :null => false
    t.integer "stimuluslevel_id", :null => false
    t.integer "startyear",        :null => false
    t.integer "startmonth"
    t.integer "endyear"
    t.integer "endmonth"
  end

  create_table "user_techproducts", :force => true do |t|
    t.integer  "user_id",        :null => false
    t.integer  "techproduct_id", :null => false
    t.integer  "userrole_id"
    t.integer  "year",           :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "user_techproducts", ["user_id", "techproduct_id", "userrole_id"], :name => "user_techproducts_techproduct_id_key", :unique => true

  create_table "user_theses", :force => true do |t|
    t.integer  "thesis_id",       :null => false
    t.integer  "user_id",         :null => false
    t.integer  "roleinthesis_id", :null => false
    t.text     "other"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "userconferences", :force => true do |t|
    t.integer  "conference_id",       :null => false
    t.integer  "user_id",             :null => false
    t.integer  "roleinconference_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "userconferences", ["conference_id", "user_id", "roleinconference_id"], :name => "userconferences_user_id_key", :unique => true

  create_table "usercredits", :force => true do |t|
    t.integer "user_id"
    t.integer "internalusergive_id"
    t.integer "externalusergive_id"
    t.boolean "usergive_is_internal"
    t.text    "other"
    t.integer "year",                 :null => false
    t.integer "month"
  end

  create_table "usercreditsarticles", :force => true do |t|
    t.integer "usercredits_id", :null => false
    t.integer "articles_id",    :null => false
  end

  add_index "usercreditsarticles", ["usercredits_id", "articles_id"], :name => "usercreditsarticles_usercredits_id_key", :unique => true

  create_table "usercreditsbooks", :force => true do |t|
    t.integer "usercredits_id", :null => false
    t.integer "books_id",       :null => false
  end

  add_index "usercreditsbooks", ["usercredits_id", "books_id"], :name => "usercreditsbooks_usercredits_id_key", :unique => true

  create_table "usercreditsconferencetalks", :force => true do |t|
    t.integer "usercredits_id",     :null => false
    t.integer "conferencetalks_id", :null => false
  end

  add_index "usercreditsconferencetalks", ["usercredits_id", "conferencetalks_id"], :name => "usercreditsconferencetalks_usercredits_id_key", :unique => true

  create_table "usercreditsgenericworks", :force => true do |t|
    t.integer "usercredits_id",  :null => false
    t.integer "genericworks_id", :null => false
  end

  add_index "usercreditsgenericworks", ["usercredits_id", "genericworks_id"], :name => "usercreditsgenericworks_usercredits_id_key", :unique => true

  create_table "userrefereedpubs", :force => true do |t|
    t.integer "refereedpubs_id",  :null => false
    t.boolean "user_is_internal"
    t.integer "externaluser_id"
    t.integer "internaluser_id"
  end

  add_index "userrefereedpubs", ["refereedpubs_id", "externaluser_id", "internaluser_id"], :name => "userrefereedpubs_refereedpubs_id_key", :unique => true

  create_table "userresearchgroups", :force => true do |t|
    t.integer "researchgroup_id", :null => false
    t.integer "year",             :null => false
    t.boolean "user_is_internal"
    t.integer "externaluser_id"
    t.integer "internaluser_id"
    t.integer "moduser_id"
  end

  add_index "userresearchgroups", ["researchgroup_id", "internaluser_id"], :name => "userresearchgroups_researchgroup_id_key", :unique => true
  add_index "userresearchgroups", ["researchgroup_id", "externaluser_id"], :name => "userresearchgroups_researchgroup_id_key1", :unique => true

  create_table "userroles", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "userroles", ["name"], :name => "userroles_name_key", :unique => true

  create_table "users", :force => true do |t|
    t.text     "login",                           :null => false
    t.text     "passwd"
    t.text     "salt"
    t.integer  "userstatus_id",    :default => 1, :null => false
    t.text     "email"
    t.text     "homepage"
    t.text     "blog"
    t.text     "calendar"
    t.text     "pkcs7"
    t.text     "token"
    t.datetime "token_expiry"
    t.integer  "user_incharge_id"
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "users", ["id"], :name => "users_id_idx"
  add_index "users", ["login"], :name => "users_login_idx"
  add_index "users", ["login"], :name => "users_login_key", :unique => true

  create_table "users_logs", :force => true do |t|
    t.integer  "user_id",           :null => false
    t.integer  "old_userstatus_id", :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "usersstatuses_comments", :force => true do |t|
    t.integer  "user_id",       :null => false
    t.integer  "userstatus_id", :null => false
    t.text     "comments",      :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  create_table "userstatuses", :force => true do |t|
    t.text     "name",       :null => false
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "userstatuses", ["name"], :name => "userstatuses_name_key", :unique => true

  create_table "volumes", :force => true do |t|
    t.text     "name",       :null => false
    t.integer  "moduser_id"
    t.datetime "created_on"
    t.datetime "updated_on"
  end

  add_index "volumes", ["name"], :name => "volumes_name_key", :unique => true

end
