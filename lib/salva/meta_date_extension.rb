# This module extends the MetaSeach plugin to generate methods based 
# on _like_ignore_case, by_soundex and by_difference prefixes.
module MetaDateExtension
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def inherited(subclass)
      super
      if subclass.column_names.include? 'year' and subclass.attribute_names.include? 'month'
        include MetaDateExtension::DateMethods
        subclass.send :include, MetaDateExtension::DateMethods
      elsif (subclass.column_names & ['startyear', 'startmonth', 'endyear', 'endmonth']).size == 4
        include MetaDateExtension::DateMethods
        subclass.send :include, MetaDateExtension::StartEndDateMethods
      end
    end
  end

  module DateMethods
    def localize_date(year, month, format=:month_and_year)
      if !year.nil? and !month.nil?
        I18n.localize(Date.new(year, month, 1), :format => format).downcase
      elsif !year.nil?
        year
      end
    end
  end

  module StartEndDateMethods
    def start_date
      'Fecha de inicio: ' + localize_date(startyear, startmonth).to_s  if !startyear.nil? or !startmonth.nil?
    end

    def end_date
      'Fecha de conclusión: ' + localize_date(endyear, endmonth).to_s if !endyear.nil? or !endmonth.nil?
    end    
  end

  module DateMethods
    def date
      localize_date(year, month)
    end
  end
end

ActiveRecord::Base.send :include, MetaDateExtension
