require 'salva'
class Public::DocumentsController < ActionController::Base
  include Salva
  helper :application, :table, :theme, :user, :navigator, :date
  layout 'public'

  def index
    docs =  get_documents('titles').split(',').collect {|d| d.strip }
    @collection = docs.collect {|d| d.strip }.collect { |name| 
      @documenttype = Documenttype.find_by_name(name) 
      unless @documenttype.nil?
        @documents = Document.find(:all, :conditions => ['documenttype_id = ?', @documenttype.id], :order => 'startdate DESC')
        {:title => @documenttype.name, :docs => @documents } if @documents.size > 0
      end
      }.compact
    respond_to do |format|
      format.html
    end
  end

  def user_list
    @collection = []
    @total_docs = 0
    document = Document.find(params[:id])
    Adscription.find(:all, :order => 'name ASC').each do |adscription|
      @user_documents = UserDocument.find_by_sql("SELECT user_documents.id, user_documents.document_id, user_documents.user_id FROM user_documents, people, user_adscriptions WHERE user_documents.document_id = #{document.id} AND user_documents.status = 't' AND user_documents.user_id = people.user_id AND user_documents.user_id = user_adscriptions.user_id AND people.user_id = user_adscriptions.user_id AND user_adscriptions.adscription_id = #{adscription.id}")
      unless @user_documents.nil?
        @total_docs += @user_documents.size
        @collection << { :adscription => adscription.name, :docs => @user_documents } if @user_documents.size > 0
      end
    end
    @document_title = document.documenttype.name + ' ' + document.title.strip 
    respond_to do |format|
      format.html { render :action => "user_list"}
    end
  end

  def show
    @record = UserDocument.find(params[:id])
    filename = @record.user.login + '_' + @record.filename.downcase
    send_data(@record.file, :filename => filename, :type => "application/"+@record.content_type.to_s, :disposition => "attachment")
  end
end
