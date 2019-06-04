# encoding: utf-8
ActiveAdmin.register Indivadvice, :as => 'ProfessorAdvice' do
  menu :parent => 'Vinculación', :label => 'Asesoría de personal académico'

  controller do
    def scoped_collection
      Indivadvice.professors
    end
  end

  controller do
    def index
      if params.has_key? :q and params[:q].has_key? :among and !params[:q][:among].is_a? Array
        params[:q][:among] = params[:q][:among].split(',').collect(&:to_i)
      end
      index!
    end
  end

  index :title => 'Asesoría de personal académico' do
    column :id

    column :indivname
    column :hours
    column :startyear
    column :startmonth
    column :endyear
    column :endmonth
    column(:institution) { |record| record.institution.name unless record.career_id.nil? }
    column(:country) { |record| record.institution.country_name unless record.career_id.nil? }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.startyear }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :indivname
  filter :user, :label => 'Académico'
  filter :among, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse.collect {|y| [y, [y,1, y, 12].join(',') ]}, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select

  csv do
    column :indivname
    column :hours
    column :startyear
    column :startmonth
    column :endyear
    column :endmonth
    column(:institution) { |record| record.institution.name unless record.career_id.nil? }
    column(:country) { |record| record.institution.country_name unless record.career_id.nil? }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name record.user.id,record.startyear }
#    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
