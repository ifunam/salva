# encoding: utf-8
ActiveAdmin.register UserGenericwork, :as => "PopularScienceWork"  do
  menu :parent => 'Divulgación', :label => 'Trabajos de divulgación'

  controller do
    def scoped_collection
      UserGenericwork.popular_science
    end
  end

  index :title => 'Trabajos de divulgación' do
    column(:id) { |record| record.genericwork.id }
    column(:title) { |record| record.genericwork.title }
    column(:authors) { |record| record.genericwork.authors }
    column(:institution)  { |record| record.genericwork.institution_name }
    column(:country)  { |record| record.genericwork.institution_country }
    column(:publisher) { |record| record.genericwork.publisher_name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column :userrole
    column(:year) { |record| record.genericwork.year}
    column(:month) { |record| record.genericwork.month }
    column(:vol) { |record| record.genericwork.vol }
    column(:pages) { |record| record.genericwork.pages }
    column(:genericworktype) { |record| record.genericwork.genericworktype.name }
    column(:genericworkstatus) { |record| record.genericwork.genericworkstatus.name }
  end

  filter :user, :label => 'Académico'
  filter :userrole, :label => 'Rol'
  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select
  filter :genericworkstatus_id, :collection => proc { Genericworkstatus.all }, :label => 'Status', :as => :select
  filter :genericworktype_id, :collection => proc { Genericworktype.popular_science }, :label => 'Tipo', :as => :select

  csv do
    column(:title) { |record| record.genericwork.title }
    column(:authors) { |record| record.genericwork.authors }
    column(:institution)  { |record| record.genericwork.institution_name }
    column(:country)  { |record| record.genericwork.institution_country }
    column(:publisher) { |record| record.genericwork.publisher_name }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:userrole) { |record| record.userrole.name }
    column(:year) { |record| record.genericwork.year}
    column(:month) { |record| record.genericwork.month }
    column(:vol) { |record| record.genericwork.vol }
    column(:pages) { |record| record.genericwork.pages }
    column(:genericworktype) { |record| record.genericwork.genericworktype.name }
    column(:genericworkstatus) { |record| record.genericwork.genericworkstatus.name }
  end
end
