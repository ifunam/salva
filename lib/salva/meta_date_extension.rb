# This module extends the models with attributes: year and month, or
# startyear, startmonth, endyear and endmonth.
#
# Class methods: since and until
# Instance methods: date or start_date and end_date
require 'pry'
module Salva::MetaDateExtension
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def inherited(subclass)
      super

      # patch for ActiveRecord::StatementInvalid: PG::UndefinedTable: ERROR:  relation "internal_metadata" does not exist
      #   LINE 8:  WHERE a.attrelid = '"internal_metadata"'::regclass
      begin
        if subclass.column_names.include?('year') && subclass.column_names.include?('month')
          subclass.send :include, Salva::MetaDateExtension::SimpleDateMethods
          subclass.class_eval do
            simple_date_scopes
          end
        elsif (subclass.column_names & ['startyear', 'startmonth', 'endyear', 'endmonth']).size == 4 and !subclass.column_names.include?('start_date') and !subclass.column_names.include?('end_date')
          subclass.send :include, Salva::MetaDateExtension::StartEndDateMethods
          subclass.class_eval do
            start_end_date_scopes
          end
        elsif subclass.column_names.include? 'start_date' and subclass.column_names.include? 'end_date'
          subclass.send :include, Salva::MetaDateExtension::DateRangeMethods
          subclass.class_eval do
            date_range_scopes
          end
        elsif (subclass.column_names & ['startyear', 'endyear']).size == 2 and !subclass.column_names.include?('startmonth')
          subclass.class_eval do
            year_range_scopes
          end
        elsif subclass.column_names.include? 'year' and !subclass.column_names.include? 'month'
          subclass.class_eval do
            only_year_scopes
          end
        end
      rescue ActiveRecord::StatementInvalid
        return
      end
    end

    protected

    def start_end_date_scopes
       scope :since, lambda { |year, month| where{{:startyear.gteq => year, :startmonth.gteq => month}} } unless respond_to? :since
       scope :until, lambda { |year, month| where{{:endyear.lteq => year, :endmonth.lteq => month}} } unless respond_to? :until

       unless respond_to? :among
         scope :among, lambda { |start_year, start_month, end_year, end_month|
          where{
            ({:startyear.gteq => start_year, :startmonth.gteq => start_month, :endyear.lteq => end_year, :endmonth.lteq => end_month}) |
            ({:startyear.lteq => start_year, :endyear.gteq => end_year }) |
            ({:startyear.lteq => start_year, :endyear => nil})
          }
        }
        # search_methods :among, :splat_param => true, :type => [:integer, :integer, :integer, :integer]
      end

      date_search_methods
    end

    def simple_date_scopes
      unless defined? @@ignore_meta_date
        scope :since, lambda { |year, month| where{
          {:year.gteq => year, :month.gteq => month} |
          {:year.gteq => year, :month => nil} 
          } 
        } unless respond_to? :since
        scope :until, lambda { |year, month| 
          where{
            {:year.lteq => year, :month.lteq => month} |
            {:year.lteq => year, :month => nil}
          } } unless respond_to? :until
      end
      date_search_methods
    end

    def date_range_scopes
      scope :since, lambda { |date| where{{:start_date.gteq => date}} } unless respond_to? :since
      scope :until, lambda { |date| where{{:end_date.lteq => date}} } unless respond_to? :until

      # search_methods :since, :until
      unless respond_to? :among
        scope :among, lambda { |start_date, end_date|
          where{
            ({:start_date.gteq => start_date, :end_date.lteq => end_date}) |
            ({:start_date.lt => start_date, :end_date.gt => end_date}) |
            ({:start_date.lteq => start_date, :end_date.lteq => end_date, :end_date.gteq => start_date}) |
            ({:start_date.gteq => start_date, :end_date.gteq => end_date, :start_date.lteq => end_date})
            ({:start_date.gteq => start_date, :end_date => nil, :start_date.lteq => end_date}) |
            ({:end_date.lteq => end_date, :start_date => nil, :end_date.gteq => start_date}) |
            ({:start_date.gteq => start_date, :end_date.lteq => end_date, :start_date.lt => end_date}) |
            ({:end_date.lteq => end_date, :end_date.gteq => start_date, :start_date.lt => end_date}) |
            ({:end_date.gteq => end_date, :end_date.gteq => start_date, :start_date.lt => end_date}) 
          }
        }
        # search_methods :among, :splat_param => true, :type => [:date, :date]
      end
    end

    def only_year_scopes
      scope :since, lambda { |year| where{{:year.gteq => year}} } unless respond_to? :since
      scope :until, lambda { |year| where{{:year.lteq => year}} } unless respond_to? :until
      # search_methods :since, :until
      unless respond_to? :among
        scope :among, lambda { |start_year, end_year| since(start_year).until(end_year)}
        # search_methods :among, :splat_param => true, :type => [:integer, :integer]
      end
    end

    def year_range_scopes
      scope :since, lambda { |year| where{{:startyear.gteq => year}} } unless respond_to? :since
      scope :until, lambda { |year| where{{:endyear.lteq => year}} } unless respond_to? :until
      # search_methods :since, :until
      unless respond_to? :among
        scope :among, lambda { |start_year, end_year|
          where{
            ({:startyear.gteq => start_year, :endyear.lteq => end_year}) |
            ({:startyear.lteq => start_year, :endyear.gteq => end_year}) |
            ({:startyear.lt => start_year, :endyear.lteq => end_year, :endyear.gteq => start_year}) |
            ({:startyear.lteq => start_year, :endyear => nil})
          }
        }
        # search_methods :among, :splat_param => true, :type => [:integer, :integer]
      end
    end

    def date_search_methods
      # search_methods :since, :splat_param => true, :type => [:integer, :integer] if respond_to? :since
      # search_methods :until, :splat_param => true, :type => [:integer, :integer] if respond_to? :until
    end
  end

  module DateMethods
    protected
    ::I18n.locale = I18n.locale.to_sym

    def localize_date(year, month, format=:month_and_year)
      if year.to_i > 0 and (month.to_i > 0 and month.to_i <= 12)
        I18n.localize(Date.new(year, month, 1), :format => format)
      elsif !year.nil?
        year
      end
    end
  end

  module StartEndDateMethods
    include Salva::MetaDateExtension::DateMethods

    def start_date(scope=nil)
      I18n.t(:start_date, :scope => scope) + ': ' + localize_date(startyear, startmonth).to_s unless startyear.nil?
    end

    def end_date(scope=nil)
      I18n.t(:end_date, :scope => scope) + ': ' + localize_date(endyear, endmonth).to_s unless endyear.nil?
    end
  end

  module SimpleDateMethods
    include Salva::MetaDateExtension::DateMethods

    def date
      localize_date(year, month)
    end
  end

  module DateRangeMethods
    def localized_start_date
      if attributes['start_date'].is_a? Date
        I18n.t(:start_date) + ': ' +  I18n.localize(attributes['start_date'], :format => :long_without_day)
      end
    end

    def localized_end_date
      if attributes['end_date'].is_a? Date
        I18n.t(:end_date) + ': ' +  I18n.localize(attributes['end_date'], :format => :long_without_day)
      end
    end
  end
end

ActiveRecord::Base.send :include, Salva::MetaDateExtension
