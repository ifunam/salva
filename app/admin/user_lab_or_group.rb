# encoding: utf-8
ActiveAdmin.register UserLabOrGroup do
  menu :parent => 'Catálogos'
  filter :user
  filter :lab_or_group

  index :title => 'Laboratorios o grupos' do
    column(:user) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:lab_or_group_name) { |record| record.lab_or_group.name }
  end

  csv do
    column(:user_name) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:lab_or_group_name) { |record| record.lab_or_group.name }
  end

end
