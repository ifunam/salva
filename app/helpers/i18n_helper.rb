# encoding: utf-8
module I18nHelper
  def translate_category(string)
     case string
       when /Investigador Tit\. C/
            "Professor" 
       when /Investigador Tit\. B/
         "Associate Professor" 
       when /Investigador Tit\. A/
         "Assistant Professor" 
       when /(Investigador Asoc\.)|posdoc/
         "Research Associate" 
       when /Técnico académico/
          "Technician" 
        when /emérito/ 
          "Distinguished University Professor" 
       else 
          "Not Defined"
     end
  end

  def localized_month_list
    Range.new(1,12).collect do |m|
      [I18n.localize(Date.new(2012,m,1), :format => :month_name), m]
    end
  end
end
