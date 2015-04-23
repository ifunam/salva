# encoding: utf-8
ActiveAdmin.register UserGenericwork, :as => "TechnicalReport"  do
  menu :parent => 'Reportes', :label => 'Reportes técnicos'

  controller do
    def scoped_collection
      UserGenericwork.technical_reports
    end
  end

  index :title => 'Reportes técnicos' do
    column :id
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
