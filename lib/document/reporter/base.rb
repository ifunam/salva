require 'document/reporter/section'
module Reporter
  class Base
    @@body = Section.new
    def self.build_sections
      create_section :profile do |s|
        s.collection :user_stimuli
        s.collection :user_schoolarships
      end

     create_section :publications do |s|
       s.collection :articles, :scope => :published
       s.collection :unpublished_articles, :class_name => 'Article', :scope => :unpublished
       s.collection :technical_reports, :class_name => 'Genericwork', :scope => :technical_reports
     end

     create_section :seminary_and_conferences do |s|
       s.collection :seminaries, :scope => :as_not_attendee
     end

     create_section :popular_science do |s|
       s.collection :newspaper_articles, :class_name => 'Newspaperarticle', :date_format => true 
       s.collection :popular_science_works, :class_name => 'Genericwork', :scope => :popular_science
     end
    end

    def self.create_section(title)
      section = Section.new(title)
      yield section if block_given?
      body.add_child(section)
    end

    def self.body
      @@body
    end

    def initialize(attributes={})
      @start_date = attributes[:start_date]
      @end_date = attributes[:end_date]
      @attributes = extract_options(attributes)
      Reporter::Base.build_sections
    end

    def build
      sections.collect do |section|
        collections = subsections(section)
        if collections.is_a? Array and collections.size > 0
          { :title => I18n.t("reporter.#{section.title}"), :subsections => collections }
        end
      end.compact
    end

    private

    def sections
      @@body.sections
    end

    def subsections(section)
      section.sections.collect do |subsection|
        records = collection(subsection)
        if records.is_a? Array and records.size > 0
          { :title => I18n.t("reporter.#{subsection.title}"), :collection => records }
        end
      end.compact
    end

    def collection(subsection)
      options = subsection.date_format? ? date_options : month_and_year_options
      subsection.search(options.merge @attributes)
    end

    def extract_options(attributes)
      attributes.delete :start_date
      attributes.delete :end_date
      attributes
    end

    def date_options
      { :between => [start_date, end_date] }
    end

    def month_and_year_options
       { :since => [ start_date.year, start_date.month ], :until => [ end_date.year, end_date.month ] }
    end

    def start_date
       Date.parse(@start_date) or (Date.today - 1)
    end

    def end_date
      Date.parse(@end_date) or Date.today
    end
  end
end
