# encoding: utf-8
ActiveAdmin.register User do
  menu :priority => 1

  index do
    column :id
    column "Foto", :sortable => false do |user|
      image_tag(user.avatar, :alt => "Foto")
    end
    column :login
    column(:worker_number) { |record| record.jobposition_log.nil? ? "":record.jobposition_log.worker_key }
    column :email
    column :fullname_or_email, :sortable => false
    column(:adscription_name) { |record| record.adscription_name record.id,Time.now.year }
    column :category_name, :sortable => false
    column :user_incharge_fullname, :sortable => false
    column :userstatus
    default_actions
  end

  filter :fullname, :as => :string
  filter :login
  filter :adscription, :collection => proc { Adscription.enabled.all }, :as => :select
  filter :jobpositioncategory, :collection => proc { Jobpositioncategory.for_researching }, :as => :select
  filter :schoolarship, :collection => proc { Schoolarship.posdoctoral_scholar.collect {|record|[ record.to_s,  record.id]} }, :as => :select
  filter :userstatus
  filter :jobposition_start_date_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select
  filter :jobposition_end_date_year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select

  form :html => { :multipart => true } do |f|
    f.inputs I18n.t("active_admin.user") do
      f.input :login, :as => :string, :input_html => {:style => 'width: 100px;' }
      f.input :email, :as => :string
      f.object.userstatus_id = 2 if f.object.new_record?
      f.input :userstatus, :as => :radio
      if f.object.new_record?
        f.input :password, :as => :password
        f.input :password_confirmation, :as => :password
      end
      f.input :user_incharge, :collection => User.activated.collect {|record| [record.to_s, record.id] }, :as => :select, :input_html => { :allow_single_deselect => true}

      f.inputs I18n.t("active_admin.user_group"), :for => [:user_group, f.object.user_group || UserGroup.new] do |ug_form|
        ug_form.input :group, :as => :radio
      end

      f.inputs I18n.t("active_admin.jobposition_log"), :for => [:jobposition_log, f.object.jobposition_log || JobpositionLog.new(:academic_years=>nil,:administrative_years=>0)] do |jpl_form|
        jpl_form.input :worker_number, :as => :string
        if f.object.id.nil?
          jpl_form.input :worker_key, :as => :string, :input_html => { :value => (User.last.id+1).to_s }
          jpl_form.input :academic_years, :as => :hidden, :value => 0
        elsif f.object.jobposition_log.nil?
          jpl_form.input :worker_key, :as => :string, :input_html => { :value => f.object.id.to_s }
          jpl_form.input :academic_years, :as => :hidden, :value => 0
        else
          jpl_form.input :worker_key, :as => :string
        end
      end

      f.inputs I18n.t("active_admin.personal_info"), :for => [:person, f.object.person || Person.new(:country_id => 484, :state_id => 9, :city_id => 64)] do |p_form|
        p_form.input :firstname, :as => :string
        p_form.input :lastname1, :as => :string
        p_form.input :lastname2, :as => :string
        p_form.input :title, :as => :string, :input_html => {:style => 'width: 100px;' }
        p_form.input :title_en, :as => :string, :input_html => {:style => 'width: 100px;' }
        p_form.input :dateofbirth, :as => :string, :input_html => { :class => 'birthdate', :style => 'width: 70px;' }
        p_form.input :gender, :as => :radio, :collection => [['Másculino', true], ['Femenino', false]]
        p_form.input :maritalstatus, :as => :select, :input_html => { :class => "chosen-select" }
        p_form.input :country, :as => :select
        p_form.input :state, :as => :select
        p_form.input :city, :as => :select
      end

      f.object.user_identifications << UserIdentification.new if f.object.new_record? and f.object.user_identifications.nil?
      f.has_many :user_identifications do |item|
        item.input :idtype, :as => :select, :input_html => { :class => "chosen-select" }
        item.input :descr, :as => :string
      end

      f.inputs I18n.t("active_admin.professional_address"), :for => [:address, f.object.address || Address.new(:building_id => 1)] do |a_form|
        a_form.input :addresstype_id, :as => :hidden, :value => 1
        a_form.input :country_id, :as => :hidden, :value => 484
        a_form.input :state_id, :as => :hidden, :value => 9
        a_form.input :city_id, :as => :hidden, :value => 64
        a_form.input :zipcode, :as => :hidden, :value => Salva::SiteConfig.institution('zipcode').to_s 
        a_form.input :pobox, :as => :hidden, :value => Salva::SiteConfig.institution('pobox').to_s
        a_form.input :is_postaddress, :as => :hidden, :value => true
        a_form.input :building, :collection => Building.all,  :as => :select
        a_form.input :location, :as => :string
        a_form.input :phone, :as => :string
        a_form.input :phone_extension, :as => :string, :input_html => {:style => 'width: 100px;' }
        a_form.input :fax, :as => :string
      end

      f.inputs I18n.t("active_admin.jobposition_and_adscription"), :for => [:jobposition, f.object.most_recent_jobposition || Jobposition.new] do |p_form|
        p_form.input :jobpositioncategory, :collection => Jobpositioncategory.for_researching,  :as => :select
        p_form.input :contracttype
        p_form.input :institution_id, :as => :hidden, :value => Institution.where(:administrative_key => Salva::SiteConfig.institution('administrative_key').to_s).first.id
        p_form.input :start_date, :as => :string, :input_html => { :class => 'start-date', :style => 'width: 70px;' }
        p_form.input :end_date, :as => :string, :input_html => { :class => 'end-date', :style => 'width: 70px;' }
        p_form.input :place_of_origin, :as => :string
        p_form.inputs I18n.t("active_admin.adscription"), :for => [:user_adscription, p_form.object.user_adscription || UserAdscription.new] do |a_form|
          a_form.input :adscription, :collection => Adscription.enabled.all,  :as => :select, :label => false
        end
      end
      f.has_many :reports do |item|
        item.input :document_type, :collection => DocumentType.all, :as => :select, :input_html => { :class => "chosen-select" } 
        item.input :file
      end
    end
    f.buttons
  end

  show do |user|
    attributes_table do
      h3 I18n.t("active_admin.user")
      attributes_table_for user do
        row :photo do 
          image_tag(user.avatar, :alt => "Foto")
        end

        row :login
        row :email
        row :userstatus
        unless user.user_incharge.nil?
          row :user_incharge do
            user.user_incharge.fullname_or_email
          end
        end
      end

      unless user.jobposition_log.nil?
        h3 I18n.t("active_admin.jobposition_log")
        attributes_table_for user.jobposition_log do
          row :worker_key
          row :worker_number
        end
      end

      unless user.person.nil?
        h3 I18n.t("active_admin.personal_info")

        attributes_table_for user.person do
          row :firstname
          row :lastname1
          row :lastname2
          row :title
          row :title_en
          row :dateofbirth
          row :gender do
            user.person.gender == true ? 'Másculino' : 'Femenino'
          end
          row :maritalstatus
          row :country
          row :state
          row :city
          row :contact_name_1
          row :contact_phonenumber_1
          row :medical_condition
          row :medical_instruction
          row :hospital
          row :insurance
          if user.has_contact_2?
            row :contact_name_2
            row :contact_phonenumber_2
          end
          if user.has_contact_3?
            row :contact_name_3
            row :contact_phonenumber_3
          end
        end
      end

      if user.user_identifications.count > 0
        h3 I18n.t("active_admin.identifications")
        user.user_identifications.each do |ui|
          attributes_table_for ui do 
            row :idtype
            row :descr
          end
        end
      end

      unless user.address.nil?
        h3 I18n.t("active_admin.professional_address")
        attributes_table_for user.address do
          row :building
          row :location
          row :phone
          row :phone_extension
          row :fax
        end
      end

      unless user.most_recent_jobposition.nil?
        h3 I18n.t("active_admin.jobposition_and_adscription")
        attributes_table_for user.most_recent_jobposition do
          row :jobpositioncategory
          row :contracttype
          row :start_date
          row :end_date
          row :place_of_origin
          unless user.most_recent_jobposition.user_adscription.nil?
            row :adscription do
              user.most_recent_jobposition.user_adscription.adscription.name
            end
          end
        end
      end

      if user.documents.count > 0
        h3 I18n.t("active_admin.documents")
        user.documents.sort_by_documenttype.each do |ud|
          attributes_table_for ud do 
            row :document_type do
              if ud.document_type_id.nil?
                link_to ud.documenttype.name, ud.url
              else
                link_to ud.document_type.name, ud.file.url
              end
            end
          end
        end
      end
    end
  end

  csv do
    column :id
    column :login
    column :email
    column :fullname_or_email
    column(:adscription_name) { |record| record.adscription_name record.id,Time.now.year }
    column :category_name
    column :user_incharge_fullname
    column(:userstatus) { |user| user.userstatus.name }
  end
end
