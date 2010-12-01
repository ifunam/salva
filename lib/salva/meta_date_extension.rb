# This module extends the models with attributes: year and month, or
# startyear, startmonth, endyear and endmonth.
#
# Class methods: since and until
# Instance methods: date or start_date and end_date
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
       scope :since, lambda { |year, month| where(:startyear >= year, :startmonth >= month) } unless respond_to? :since
       scope :until, lambda { |year, month| where(:endyear <= year, :endmonth <= month) } unless respond_to? :until
       date_search_methods
     end

     def simple_date_scopes
       scope :since, lambda { |year, month| where(:year >= year, :month >= month) } unless respond_to? :since
       scope :until, lambda { |year, month| where(:year <= year, :month <= month) } unless respond_to? :until
       date_search_methods
     end

     def date_search_methods
       search_methods :since, :splat_param => true, :type => [:integer, :integer] if respond_to? :since
       search_methods :until, :splat_param => true, :type => [:integer, :integer] if respond_to? :until
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
