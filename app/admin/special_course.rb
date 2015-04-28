# encoding: utf-8
ActiveAdmin.register UserCourse, :as => 'SpecialCourse' do
  menu :parent => 'Docencia', :label => 'Cursos especiales'

  controller do
    def scoped_collection
      UserCourse.instructors
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

  index :title => 'Cursos especiales' do
    column(:id) { |record| record.course.id }

    column(:name) { |record| record.course.name }
    column(:duration) { |record| record.course.courseduration.name }
    column(:modality) { |record| record.course.modality.name }
    column(:country) { |record| record.course.country.name }
    column(:location) { |record| record.course.location }
    column(:startyear) { |record| record.course.startyear }
    column(:startmonth) { |record| record.course.startmonth }
    column(:endyear) { |record| record.course.endyear }
    column(:endmonth) { |record| record.course.endmonth }

    column(:hoursxweek) { |record| record.course.hoursxweek }
    column(:totalhours) { |record| record.course.totalhours }

    column(:roleincourse) { |record| record.roleincourse.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  filter :among, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse.collect {|y| [y, [y,1, y, 12].join(',') ]}, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :roleincourse, :collection => proc { Roleincourse.instructors }, :label => 'Rol', :as => :select

  csv do
    column(:name) { |record| record.course.name }
    column(:duration) { |record| record.course.courseduration.name }
    column(:modality) { |record| record.course.modality.name }
    column(:country) { |record| record.course.country.name }
    column(:location) { |record| record.course.location }
    column(:startyear) { |record| record.course.startyear }
    column(:startmonth) { |record| record.course.startmonth }
    column(:endyear) { |record| record.course.endyear }
    column(:endmonth) { |record| record.course.endmonth }

    column(:hoursxweek) { |record| record.course.hoursxweek }
    column(:totalhours) { |record| record.course.totalhours }

    column(:roleincourse) { |record| record.roleincourse.name }

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end
end
