class PostdoctoralCardRequest < Prawn::Document
  def initialize(options={},&block)
    options[:template] = Rails.root.to_s + '/lib/templates/documents/postdoctoral_card_template.pdf'
    if options.has_key? :user
      @user = options[:user]
      options.delete :user
    end
    super
  end

  def to_pdf
    build_body
    render
  end
  
  def build_body
    font 'Helvetica', :style => :italic
    add_fullname
    add_user_identification
    add_jobposition_dates
    add_current_date
  end

  def add_fullname
    draw_text @user.person.firstname_and_lastname.upcase, :at => [18,330]
  end

  def add_user_identification
    user_identification =  @user.user_identification.nil? ? '-' : @user.user_identification.descr.upcase
    draw_text user_identification, :at => [400,330]
  end

  def add_jobposition_dates
    jobposition_start_date = jobposition_end_date = '-'
    unless @user.jobposition_as_postdoctoral.nil?
      jobposition_start_date = I18n.l(@user.jobposition_as_postdoctoral.start_date, :format => :long_without_day)
      unless @user.jobposition_as_postdoctoral.end_date.nil?
        jobposition_end_date = I18n.l(@user.jobposition_as_postdoctoral.end_date, :format => :long_without_day)
      end
    end
    draw_text "Del #{jobposition_start_date} al #{jobposition_end_date}", :at => [18,205]
  end

  def add_current_date
    draw_text I18n.l(Date.today, :format => :long_without_day), :at => [60,155]
  end
end
