require 'octopi'
class ExceptionNotifier::Notifier
  include Octopi

  def exception_notification(env, exception)
    @env        = env
    @exception  = exception
    @options    = (env['exception_notifier.options'] || {}).reverse_merge(self.class.default_options)
    @kontroller = env['action_controller.instance'] || MissingController.new
    @request    = ActionDispatch::Request.new(env)
    @backtrace  = clean_backtrace(exception)
    @sections   = @options[:sections]
    data        = env['exception_notifier.exception_data'] || {}

    data.each do |name, value|
      instance_variable_set("@#{name}", value)
    end

    prefix  = "#{@options[:email_prefix]}#{@kontroller.controller_name}##{@kontroller.action_name}"
    subject = "#{prefix} (#{@exception.class}) #{@exception.message.inspect}"
    subject = subject.length > 120 ? subject[0...120] + "..." : subject

    mail(:to => @options[:exception_recipients], :from => @options[:sender_address], :subject => subject) do |format|
      format.text { render "#{mailer_name}/exception_notification" }
    end

    github_path = File.join(Rails.root.to_s, 'config', 'github.yml')
    if File.exist? github_path
      authenticated :config => github_path do
        repo = Repository.find(:name => "salva", :user => "ifunam")
        Octopi::Issue.open(:repo => repo, :user => 'alex', :params => {:title => @exception, :body => @backtrace })
      end
    end
  end
end

