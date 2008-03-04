require 'rubygems'
require 'pdf/writer'      
require 'pdfwriter_extensions'
require 'labels'
require 'salva'

class UserReportPdfTransformer
  include Salva
  include Labels
  SIZES = [18, 16, 14, 12, 12, 12]

  attr_accessor :pdf

  def initialize(title, received_stamp=false)
    @pdf =  PDF::Writer.new  	  
    @pdf.select_font "Times-Roman"
    @pdf.info.creator = 'Salva Plataforma de Información Curricular'
    @pdf.info.title = title
    # @pdf.info.author = username
    @pdf.start_page_numbering(@pdf.page_width - 20, 10, 8, :right, " <PAGENUM>") 
    
    @pdf.add_image_from_file RAILS_ROOT + "/public/images/unam_escudo.jpg", 25, 660, 100
  
    @pdf.text(title, :font_size => SIZES[0], :justification => :center)
    myinstitution =  get_conf('institution')
    @pdf.move_pointer(4)
    @pdf.text(myinstitution, :font_size => SIZES[1], :justification => :center)

    @pdf.move_pointer(100)
  end

  def add_received_stamp
    received_stamp = RAILS_ROOT + "/themes/#{get_conf('theme')}/images/received_stamp.jpg"    
    @pdf.add_image_from_file received_stamp, 480, 680, 100 if File.exists?(received_stamp) 
  end
  
  def report_code(report_code)
    @pdf.info.subject = report_code
    @pdf.start_page_numbering(20, 10, 8, :left, "#{report_code}")
  end

  def render
    @pdf.render
  end

  def add_data(data)  
    data.each do |hash|
      @pdf.text(get_label(hash[:title])+"\n", :font_size => SIZES[hash[:level]]) if hash.has_key?(:title)
      @pdf.move_pointer(10)
      if hash.has_key?(:data)
        paragraph_data(hash[:data])
        @pdf.move_pointer(5)
      end
    end
  end

  def paragraph_data(data)
    width = 198.324
    
    num = 1
    data.each do |text| 
      @pdf.start_new_page if @pdf.y.to_i < 75
      if text.is_a?Array
        if !text[1].nil? and !text[1].blank?
          label = '<b>'+get_label(text[0])+': </b>' 
          mywidth = @pdf.text_line_width(label) > width ? @pdf.text_line_width(label) : width
          y = @pdf.y
          @pdf.text(label, :font_size => SIZES[5])
          @pdf.y = y
          @pdf.text(text[1].to_s, :font_size => SIZES[5], :left => mywidth) 
        end
      else
        y = @pdf.y
        @pdf.text(num.to_s + '. ', :font_size => SIZES[5])  
        item_width = @pdf.text_line_width(num.to_s + '. ')
        @pdf.y = y       
        @pdf.text(text, :font_size => SIZES[5], :justification => :full, :left => item_width) 
        num += 1
      end
      @pdf.move_pointer(2)
    end
  end
  
  def add_text(text)
    @pdf.text(text, :font_size => SIZES[5], :justification => :full) 
  end

  def add_textile(text)
    lines = text.split("\n")

    num = [ 1, 1, 1, 1 ]

    lines.each { |line|

      if line =~ /^h(\d). (.+)$/
        n = $~[1]
        t = preprocess_textile($~[2])
        @pdf.text("<b>#{t}</b>", :font_size => SIZES[n.to_i], :justification => :full)
         num[0] = 1
      elsif line =~ /^\s*(\*+) (.+)$/
        n = $~[1]
        t = '<C:bullet/> '+ preprocess_textile($~[2])
        item_width = 10*n.size
        @pdf.text(t, :font_size => SIZES[5], :justification => :full, :left => item_width) 
         num[0] = 1
       elsif line =~ /^\s*(#+) (.+)$/
        n = $~[1].size - 1
        t = preprocess_textile($~[2])
        item_width = @pdf.text_line_width(num[n].to_s + '. ')

        y = @pdf.y
        @pdf.text(num[n].to_s + '. ', :font_size => SIZES[5], :left => item_width*n)  
        @pdf.y = y  
        @pdf.text(t, :font_size => SIZES[5], :justification => :full, :left => item_width*(n+1)) 
        num[n] += 1
        num[n+1] = 1 if n < num.size
      else        
        @pdf.text(preprocess_textile(line), :font_size => SIZES[5], :justification => :full) 
         num[0] = 1
      end
    }
  end

  private

  def preprocess_textile(line)
    while line =~ /\*(.+)\*/
      line.sub!(/\*/, '<b>')
      line.sub!(/\*/, '</b>')
    end

    while line =~ /\_(.+)\_/
      line.sub!(/_/, '<i>')
      line.sub!(/_/, '</i>')
    end

    while line =~ /\+(.+)\+/
      line.sub!(/\+/, '<i>')
      line.sub!(/\+/, '</i>')
    end
    line
  end

end
