# encoding: utf-8
require 'barby'
require 'barby/outputter/rmagick_outputter'
require 'document/user_profile'
class IdentificationCard
  include Magick

  def initialize(user_id)
    @user_profile = UserProfile.find(user_id)
  end

  def front
    @image = Magick::Image.read(Rails.root.to_s+"/lib/templates/cards/front.jpg").first
    add_fullname_and_email!
    add_category!
    add_department_and_user_incharge!
    @image.dissolve(user_image, 0.90, 1.0, 35, 20).to_blob
  end

  def back
    @image = Magick::Image.read(Rails.root.to_s+"/lib/templates/cards/back.jpg").first
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
    add_text!(@user_profile.email, 35, 260)
    add_text!(@user_profile.fullname, 290, 140, 28, BoldWeight)
  end

  def add_category!
    add_text!('Investigador Posdoctoral ', 290, 180, 24, BoldWeight)
  end

  def add_department_and_user_incharge!
    add_text!('Departamento: ', 35, 330, 24, BoldWeight)
    add_text!(@user_profile.adscription_name, 210, 330)
    unless @user_profile.responsible_academic.nil?
      add_text!('Responsable académico: ', 35, 360, 24, BoldWeight)
      add_text!(@user_profile.responsible_academic, 210, 360)
    end
  end

  def add_vigency!
    add_text! @user_profile.jobposition_period, 105, 485, 24
  end

  def user_image
    pic = Magick::Image.read(@user_profile.image_path).first
    pic.resize(220,230).border(1,1,"#000000").quantize(256, Magick::GRAYColorspace)
  end

  def barcode_image
    code = @user_profile.person_id.nil? ? @user_profile.login : @user_profile.person_id
    Barby::Code39.new(code).to_image
  end
end
