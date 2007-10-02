class UserDocumentNotifier < ActionMailer::Base
  helper ActionView::Helpers::UrlHelper

  def setup(options)
    @recipients = options[:recipients] || "salva@salva.unam.mx"
    @from = options[:from] || "salva@salva.unam.mx"
    @cc = options[:cc] || ""
    @bcc = options[:bcc] || ""
    @subject = "[SALVA] "
    @subject << options[:subject] unless options[:subject].nil?
    @body = options[:body] || {}
    @headers = options[:headers] || {}
    @charset = options[:charset] || "utf-8"
    @sent_on     = Time.now
  end

  def add_attachment(att)
    attachment :content_type => att[:content_type], :body => StringIO.new(att[:file]).read
  end

  def request_for_approval(options)
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
end
