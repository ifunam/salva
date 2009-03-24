module I18nHelper


  def translate_category(string)
     case string
       when /Investigador, Tit\. C/ 
            "Professor" 
       when /Investigador, Tit\. B/
         "Associated Professor" 
       when /Investigador, Tit\. A/ 
         "Assistant Professor" 
       when /(Investigador\, Asoc\.)|posdoc/ 
         "Dr." 
       when /Técnico académico/
          "Research Associated" 
        when /emérito/ 
          "Distinguished University Professor" 
       else 
          "Super Super Dr."
     end
  end
end