# encoding: utf-8
require 'document/reporter/base'
require 'document/user_profile'
module UserAnnualReport

  class Base
    attr_accessor :code, :signature, :received

    def self.find(user_id, year)
      new(user_id, year)
    end

    def initialize(user_id, year)
      @user_id = user_id
      @year = year
    end

    def to_pdf
      build_pdf.render
    end

    def save_pdf(filename)
      File.delete filename if File.exist? filename
      build_pdf.save filename
    end

    def build
      UserReport.find(@user_id, @year)
    end

    private

    def build_pdf
      pdf = PDFTransformer.new(@user_id, @year)
      pdf.code = code unless code.nil?
      pdf.signature = signature unless signature.nil?
      pdf.received = true if received
      pdf
    end
  end

  class PDFTransformer
    attr_accessor :code, :signature, :received

    def initialize(user_id, year)
      @report = UserReport.find(user_id, year)
      @year = year
      @pdf = Prawn::Document.new
    end

    def render
      build
      @pdf.render
    end

    def save(path)
      build
      @pdf.render_file path
    end

    protected

    def build
      header
      profile
      sections
      footer
    end

    def header
      image_path = Rails.root.to_s + '/lib/templates/documents'
      @pdf.image "#{image_path}/unam.jpg", :at => [0, 750], :width => 100, :height => 114
      if received?
        @pdf.image "#{image_path}/received_stamp.jpg", :at => [400, 700], :width => 120
      end

      @pdf.draw_text "Informe Anual de Actividades #{@year}", :at => [140, 710], :size => 20,  :style => :bold
      @pdf.draw_text 'Instituto de Física', :at => [220, 690], :size => 18,  :style => :bold
      @pdf.move_down(100)
    end

    def profile
      @pdf.text 'Información general', :size => 16, :style => :bold, :final_gap => true
      @pdf.text "\n"
      @pdf.font 'Helvetica', :size => 12

      @pdf.text "Nombre:", :style => :bold
      @pdf.draw_text @report.profile.fullname, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Género:", :style => :bold
      @pdf.draw_text @report.profile.gender, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Fecha de nacimiento:", :style => :bold
      @pdf.draw_text @report.profile.birthdate, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Domicilio profesional:", :style => :bold
      @pdf.text_box @report.profile.address, :style => :normal, :at => [160, @pdf.cursor], :width => 370
      @pdf.move_down(50)

      @pdf.text "Teléfono:", :style => :bold
      @pdf.draw_text @report.profile.phone, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Fax:", :style => :bold
      @pdf.draw_text @report.profile.fax, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Correo electrónico:", :style => :bold
      @pdf.draw_text @report.profile.email, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "RFC o CURP:", :style => :bold
      @pdf.draw_text @report.profile.person_id, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Categoría:", :style => :bold
      @pdf.draw_text @report.profile.category_name, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Adscripción:", :style => :bold
      @pdf.draw_text @report.profile.adscription_name, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Número de trabajador:", :style => :bold
      @pdf.draw_text @report.profile.worker_id, :style => :normal, :at => [160, @pdf.cursor]

      @pdf.text "Total de citas:", :style => :bold
      @pdf.draw_text @report.profile.total_of_cites.to_s, :style => :normal, :at => [160, @pdf.cursor]

      unless @report.profile.responsible_academic.nil?
        @pdf.text "Responsable académico:", :style => :bold
        @pdf.draw_text @report.profile.responsible_academic.to_s, :style => :normal, :at => [160, @pdf.cursor]
      end
      @pdf.move_down(20)
    end

    def sections
      @report.sections.each do |section|
        @pdf.text section[:title].to_s, :size => 16, :style => :bold, :final_gap => true
        @pdf.text "\n"
        section[:subsections].each do |subsection|
          @pdf.text subsection[:title].to_s, :size => 14, :style => :bold, :final_gap => true
          @pdf.text "\n"

          counter = 1
          subsection[:collection].each do |record|
            @pdf.text [counter, record].join('. '), :size => 12, :align => :justify
            counter += 1
          end
          @pdf.text "\n" if counter > 1
        end
      end
    end

    def footer
      footer = "SALVA - Plat. Inf. Curric. a #{I18n.localize(Time.now, :format => :long).downcase}"
      @pdf.font "Times-Roman", :size => 8, :style => :italic
      @pdf.number_pages [footer, code].join(', '), [@pdf.bounds.left, 0]
      @pdf.number_pages ["Página <page> de <total>"].join(', '), [@pdf.bounds.right - 40, 0]
      unless signature.nil?
        @pdf.font "Times-Roman", :size => 8, :style => :italic
        @pdf.number_pages "Firma digital:", [@pdf.bounds.left, -12]
        @pdf.font "Times-Roman", :size => 8, :style => :normal
        @pdf.draw_text signature, :style => :normal, :at => [@pdf.bounds.left + 50, -12]
      end
    end

    def code
      [@report.profile.email, @code].compact.join(', ')
    end

    def received?
      received
    end
  end

  class UserReport

    def self.find(user_id, year)
      new(user_id, year)
    end

    def initialize(user_id, year)
      @user_id = user_id
      @year = year
    end

    def profile
      UserProfile.find(@user_id)
    end

    def sections
      @report = Reporter::Base.new(:user_id_eq => @user_id, 
                                   :start_date => "#{@year}/01/01",
                                   :end_date => "#{@year}/12/31")
      @report.build
    end
  end
end
# @annual_report = UserAnnualReport::Base.find(167, 2010)
# @annual_report.save_pdf('/tmp/annual_report.pdf')
