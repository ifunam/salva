class ResumeController < ApplicationController

  def index
    as_html
  end

  def as_html
    @resume = Resume.new(session[:user])
    @html = @resume.as_html
    render :action => 'index'
  end

  def as_text
    @resume = Resume.new(session[:user])
    send_data(@resume.as_text, :filename => 'curriculum.txt',  :type => "text/plain; charset=utf-8", :disposition => "inline")
  end

  def as_pdf
    @resume = Resume.new(session[:user])
    send_data(@resume.as_pdf, :filename => 'curriculum.pdf', :type => "application/pdf", :disposition => "inline")
  end
end
