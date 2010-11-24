# This module extends the MetaSeach plugin to generate methods based 
# on _like_ignore_case, by_soundex and by_difference prefixes.
module MetaDateExtension
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def inherited(subclass)
      super
      if subclass.column_names.include? 'year' and subclass.column_names.include? 'month'
        subclass.send :include, MetaDateExtension::SimpleDateMethods
        subclass.class_eval do
          simple_date_scopes
        end
      elsif (subclass.column_names & ['startyear', 'startmonth', 'endyear', 'endmonth']).size == 4
        subclass.send :include, MetaDateExtension::StartEndDateMethods
        subclass.class_eval do
          start_end_date_scopes
        end
      end
    end

    protected

    def start_end_date_scopes
      scope :start_year, lambda { |year| where(:startyear >= year) }
      scope :start_month, lambda { |month| where(:startmonth >= month) }

      scope :end_year, lambda { |year| where(:endyear <= year) }
      scope :end_month, lambda { |month| where(:endmonth <= month) }

      scope :since, lambda {|year, month| self.start_year(year).start_month(month)}
      scope :until, lambda {|year, month| self.end_year(year).end_month(month)}
    end

    def simple_date_scopes
      scope :start_year, lambda { |year| where(:year >= year) }
      scope :start_month, lambda { |month| where(:month >= month) }
      scope :end_year, lambda { |year| where(:year <= year) }
      scope :end_month, lambda { |month| where(:month <= month) }

      scope :since, lambda {|year, month| self.start_year(year).start_month(month)}
      scope :until, lambda {|year, month| self.end_year(year).end_month(month)}
    end
  end

  module DateMethods
    protected
    def localize_date(year, month, format=:month_and_year)
      if !year.nil? and !month.nil?
        I18n.localize(Date.new(year, month, 1), :format => format)
      elsif !year.nil?
        year
      end
    end
  end

  module StartEndDateMethods
    include MetaDateExtension::DateMethods

    def start_date
      I18n.t(:start_date) + ': ' + localize_date(startyear, startmonth).to_s  if !startyear.nil? or !startmonth.nil?
    end

    def end_date
      I18n.t(:end_date) + ': ' + localize_date(endyear, endmonth).to_s if !endyear.nil? or !endmonth.nil?
    end
  end

  module SimpleDateMethods
    include MetaDateExtension::DateMethods

    def date
      localize_date(year, month)
    end
  end
end

ActiveRecord::Base.send :include, MetaDateExtension
