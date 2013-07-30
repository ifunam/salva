# encoding: utf-8
class JournalNotifier < ActionMailer::Base
  include Salva::SiteConfig
  include Resque::Mailer if File.exist? File.join(Rails.root.to_s, 'config', 'resque.yml')

  default :from => Salva::SiteConfig.system('email')

  def notify_to_librarian(journal_id)
    @journal = Journal.find(journal_id)
    cc = Group.where(:name => 'librarian').first.users.collect { |user| user.email }.join(', ')
    mail(:to => 'salva@fisica.unam.mx', :cc => cc, :subject => '[SALVA] - Notificación de nuevo journal') do |format|
      format.text
    end

  end
end
