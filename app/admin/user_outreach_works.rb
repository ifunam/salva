# encoding: utf-8
ActiveAdmin.register UserGenericwork, :as => "UserOutreachWork" do
  menu :parent => 'Reportes', :label => 'Trabajos de vinculación'
  controller do
    def scoped_collection
      UserGenericwork.outreach_works
    end
  end

  index :title => 'Trabajos de vinculación' do
    column :id
    column(:title) { |record| record.genericwork.title }
    column(:authors) { |record| record.genericwork.authors }
    column(:institution) { |record| record.genericwork.institution_name }
    column(:country) { |record| record.genericwork.institution_country }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column :userrole
    column(:year) { |record| record.genericwork.year}
    column(:month) { |record| record.genericwork.month }
    column(:genericworktype) { |record| record.genericwork.genericworktype.name }
    column(:genericworkstatus) { |record| record.genericwork.genericworkstatus.name }
  end

  filter :user, :label => 'Académico'
  filter :userrole, :label => 'Rol'
  filter :year, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse, :as => :select
  filter :genericworkstatus_id, :collection => proc { Genericworkstatus.all }, :label => 'Status', :as => :select
  filter :genericworktype_id, :collection => proc { Genericworktype.outreach_works }, :label => 'Tipo', :as => :select

  csv do
    column(:title) { |record| record.genericwork.title }
    column(:authors) { |record| record.genericwork.authors }
    column(:institution) { |record| record.genericwork.institution_name }
    column(:country) { |record| record.genericwork.institution_country }
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }
    column(:userrole) { |record| record.userrole.name }
    column(:year) { |record| record.genericwork.year}
    column(:month) { |record| record.genericwork.month }
    column(:genericworktype) { |record| record.genericwork.genericworktype.name }
    column(:genericworkstatus) { |record| record.genericwork.genericworkstatus.name }
  end

end
