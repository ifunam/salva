require 'document/user_profile'
class PostdoctoralCardRequest < Prawn::Document
  def initialize(options={},&block)
    options[:template] = Rails.root.to_s + '/lib/templates/documents/postdoctoral_card_template.pdf'
    if options.has_key? :user_id
      @user_profile = UserProfile.new(options[:user_id])
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
    draw_text @user_profile.firstname_and_lastname, :at => [18,330]
  end

  def add_user_identification
    draw_text @user_profile.person_id, :at => [400,330]
  end

  def add_jobposition_dates
    draw_text @user_profile.jobposition_period, :at => [18,205]
  end

  def add_current_date
    draw_text I18n.l(Date.today, :format => :long_without_day), :at => [60,155]
  end
end
