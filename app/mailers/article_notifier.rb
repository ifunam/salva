class ArticleNotifier < ActionMailer::Base
  include Salva::SiteConfig
  include Resque::Mailer if File.exist? File.join(Rails.root.to_s, 'config', 'resque.yml')

  default :from => Salva::SiteConfig.system('email')

  def author_notification(id)
    @user_article = UserArticle.find(id)
    #filename = File.basename(@user_article.article.document.file) unless @user_article.article.document.nil?

    mail(:to => @user_article.user.email, :subject => 'Notificación de registro en artículos publicados') do |format|
      format.text
     # attachments[filename] = File.read(@user_article.article.document.path) unless @user_article.article.document.nil?
    end
  end
end
