# encoding: utf-8
ActiveAdmin.register Review do
  menu :parent => 'Publicaciones', :label => 'Reseñas'

  index :title => 'Reseñas' do
    column :id
    column :authors
    column :title
    column :reviewed_work_title
    column :reviewed_work_publication
    column :published_on
    column :year
    column :month
    column :other
    column(:fullname) { |record| record.user.fullname_or_email }
    column(:worker_key) { |record| record.user.worker_key_or_login }

  end

  filter :user, :label => 'Académico'
  filter :year

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
