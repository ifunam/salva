class ResumeController < ApplicationController
  def index
     render :action => 'index'
  end

  def as_text
    send_data(Resume.render_text(:data => User.find(session[:user])),
              :filename => 'curriculum.txt',
              :type => "text/plain; charset=utf-8",
              :disposition => "inline")
  end

  def as_pdf
    send_data(Resume.render_pdf(:data => User.find(session[:user])),
              :filename => 'curriculum.pdf',
              :type => "application/pdf",
              :disposition => "inline")
  end
end
