# encoding: utf-8
ActiveAdmin.register UserJournal, :as => 'JournalCollaboration'  do
  menu :parent => 'Colaboración en publicaciones', :label => 'Colaboración revistas'

  index :title => 'Colaboración Revistas' do

    column(:id) { |record| record.id }

    column(:journal_name) { |record| record.journal_name }
    column(:journal_country) { |record| record.journal_country }
    column(:roleinjournal) { |record| record.roleinjournal.name }
    column :startyear
    column :startmonth
    column :endyear
    column :endmonth

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  controller do
    def index
      if params.has_key? :q and params[:q].has_key? :among
        params[:q][:among] = params[:q][:among].split(',').collect(&:to_i)
      end
      index!
    end
  end

  filter :among, :collection => (Date.today.year - 100 .. Date.today.year + 1).to_a.reverse.collect {|y| [y, [y,1, y, 12].join(',') ]}, :label => 'Año', :as => :select
  filter :adscription_id, :collection => proc { Adscription.enabled }, :label => 'Adscripción', :as => :select
  filter :user, :label => 'Académico'
  filter :roleinjournal
  filter :journal

  csv do
    column(:journal_name) { |record| record.journal_name }
    column(:journal_country) { |record| record.journal_country }
    column(:roleinjournal) { |record| record.roleinjournal.name }
    column :startyear
    column :startmonth
    column :endyear
    column :endmonth

    column(:fullname) { |record| record.user.fullname_or_email }
    column(:adscription) { |record| record.user.adscription_name }
    column(:worker_key) { |record| record.user.worker_key_or_login }
  end

  def index
    binding.pry
    super
  end
end
