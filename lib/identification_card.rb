require 'barby'
require 'barby/outputter/rmagick_outputter'
class IdentificationCard
  include Magick

  def initialize(user)
    @user = user
  end

  def front
    @image = Magick::Image.read(Rails.root.to_s+"/public/images/cards/front.jpg").first
    add_fullname_and_email!
    add_category!
    add_department_and_user_incharge!
    @image.dissolve(user_image, 0.90, 1.0, 35, 20).to_blob
  end

  def back
    @image = Magick::Image.read(Rails.root.to_s+"/public/images/cards/back.jpg").first
    add_text!(Date.today.to_s, 280, 331, 24, BoldWeight)
    add_vigency!
    @image.composite(barcode_image.resize(350,300), 650, 100, Magick::OverCompositeOp).to_blob
  end

  private
  def add_text!(string, x_offset, y_offset, font_size=24, font_weight=NormalWeight)
    text = Magick::Draw.new
    text.font_family = 'Arial'
    text.font_weight = font_weight
    text.pointsize = font_size
    text.stroke = 'transparent'
    text.fill = '#000000'
    text.gravity = Magick::NorthWestGravity
    text.annotate(@image, 0, 0, x_offset, y_offset, string)
  end

  def add_fullname_and_email!
    add_text!(@user.email, 35, 260)
    add_text!(@user.fullname_or_email, 290, 140, 28, BoldWeight)
  end

  def add_category!
    add_text!('Investigador Posdoctoral ', 290, 180, 24, BoldWeight)
  end

  def add_department_and_user_incharge!
    add_text!('Departamento: ', 35, 330, 24, BoldWeight)
    add_text!(@user.adscription_name, 210, 330)
    unless @user.user_incharge.nil?
      add_text!('Responsable académico: ', 35, 360, 24, BoldWeight)
      add_text!(@user.user_incharge_fullname, 210, 360)
    end
  end

  def add_vigency!
    add_text!('Vigencia:', 30, 485, 24, BoldWeight)
    jobposition_start_date = jobposition_end_date = '-'
    unless @user.jobposition_as_postdoctoral.nil?
      jobposition_start_date = I18n.l(@user.jobposition_as_postdoctoral.start_date, :format => :long_without_day)
      unless @user.jobposition_as_postdoctoral.end_date.nil?
        jobposition_end_date = I18n.l(@user.jobposition_as_postdoctoral.end_date, :format => :long_without_day)
      end
    end
    add_text! "Del #{jobposition_start_date} al #{jobposition_end_date}", 145, 485, 24
  end
  
  def user_image
    image_path = Rails.root.to_s + "/public/images/avatar_missing_icon.png"
    #image_path = @user.person.image.file.path(:card) if !@user.person.nil? and File.exist? @user.person.image.file.path
    pic = Magick::Image.read(image_path).first
    pic.resize(220,230).border(1,1,"#000000")
  end

  def barcode_image
    Barby::Code39.new(@user.user_identification.descr).to_image
  end
end
