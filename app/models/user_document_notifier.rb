require 'yaml'
class UserDocumentNotifier < ActionMailer::Base
  def setup(options)
    smtp = YAML.load(File.read("#{RAILS_ROOT}/config/mail.yml"))
    domain = smtp['settings'][:domain].to_s
    @recipients = options[:recipients] || "noreply@#{domain}"
    @from = options[:from] || "noreply@#{domain}"
    @subject = "[SALVA] "
    @subject << options[:subject] unless options[:subject].nil?
    @body = options[:body] || {}
    @headers = options[:headers] || {}
    @sent_on  = Time.now
  end

  def add_attachment(att)
    attachment :content_type => att[:content_type], :body => StringIO.new(att[:file]).read, :filename => att[:filename]
  end

  def request_for_approval(options)
    self.setup(options)
    add_attachment(options[:attachment]) if options[:attachment].is_a? Hash
  end

  def request_for_approval_notification(options)
    self.setup(options)
    add_attachment(options[:attachment]) if options[:attachment].is_a? Hash
  end

  def approval_notification(options)
    self.setup(options)
    add_attachment(options[:attachment]) if  options[:attachment].is_a? Hash
  end

  def notification_of_delivery(options)
    self.setup(options)
    add_attachment(options[:attachment]) if  options[:attachment].is_a? Hash
  end

  def deny_notification(options)
    self.setup(options)
    add_attachment(options[:attachment]) if  options[:attachment].is_a? Hash
  end
end
