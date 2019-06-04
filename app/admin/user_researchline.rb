# encoding: utf-8
ActiveAdmin.register UserResearchline do
  menu :parent => 'Catálogos'

  index :title => 'Líneas de investigación' do
    column(:worker_number) { |record| record.user.jobposition_log.nil? ? "n/a": record.user.jobposition_log.worker_key }
    column(:user_name) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:name) { |record| record.researchline.name }
    column(:name_en) { |record| record.researchline.name_en }
  end

  csv do
    column(:worker_number) { |record| record.user.jobposition_log.nil? ? "n/a": record.user.jobposition_log.worker_key }
    column(:user_name) { |record| record.user.fullname_or_email }
    column(:category) { |record| record.user.category_name }
    column(:userstatus) { |record| record.user.userstatus.name }
    column(:name) { |record| record.researchline.name }
    column(:name_en) { |record| record.researchline.name_en }
  end

end
