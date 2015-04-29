# encoding: utf-8
ActiveAdmin.register UserProject, :as => 'Project' do
  menu :parent => 'Otros', :label => 'Proyectos'

  controller do
    def index
      if params.has_key? :q and params[:q].has_key? :among and !params[:q][:among].is_a? Array
        params[:q][:among] = params[:q][:among].split(',').collect(&:to_i)
      end
      index!
    end
  end

  index :title => 'Proyectos' do
    column(:id) { |record| record.project.id }

    column(:project_name) { |record| record.project.name }
    column(:project_abbrev) { |record| record.project.abbrev }
    column(:project_responsible) { |record| record.project.responsible }
    column(:project_description) { |record| record.project.descr }
    column(:project_type) { |record| record.project.projecttype.name }
    column(:project_status) { |record| record.project.projectstatus.name }
    column(:project_startyear) { |record| record.project.startyear }
    column(:project_startmonth) { |record| record.project.startmonth }
    column(:project_endyear) { |record| record.project.endyear }
    column(:project_endmonth) { |record| record.project.endmonth }
    column(:project_financing_sources) { |record| record.project.financing_source_names }
    column(:roleinproject)

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :user, :label => 'Académico'
  filter :among, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse.collect {|y| [y, [y,1, y, 12].join(',') ]}, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :projectstatus_id, :collection => proc { Projectstatus.all }, :label => 'Status', :as => :select

  csv do
    column(:project_name) { |record| record.project.name }
    column(:project_abbrev) { |record| record.project.abbrev }
    column(:project_responsible) { |record| record.project.responsible }
    column(:project_description) { |record| record.project.descr }
    column(:project_type) { |record| record.project.projecttype.name }
    column(:project_status) { |record| record.project.projectstatus.name }
    column(:project_startyear) { |record| record.project.startyear }
    column(:project_startmonth) { |record| record.project.startmonth }
    column(:project_endyear) { |record| record.project.endyear }
    column(:project_endmonth) { |record| record.project.endmonth }
    column(:project_financing_sources) { |record| record.project.financing_source_names }
    column(:roleinproject)

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
