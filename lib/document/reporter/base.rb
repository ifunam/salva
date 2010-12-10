require 'document/reporter/section'
module Reporter
  class Base
    @@body = Section.new
    def self.build_sections
      create_section :profile do |s|
        s.collection :user_stimuli
        s.collection :user_schoolarships, :date_style => :date_range
        s.collection :user_credits
        s.collection :institutional_activities
      end

      create_section :seminary_and_conferences do |s|
        s.collection :seminaries, :scope => :as_not_attendee
      end

      create_section :publications do |s|
        s.collection :articles, :scope => :published
        s.collection :unpublished_articles, :class_name => 'Article', :scope => :unpublished
        s.collection :technical_reports, :class_name => 'Genericwork', :scope => :technical_reports
        s.collection :reviews
      end

      create_section :refereed_colaborations do |s|
        s.collection :user_journals
      end

      create_section :popular_science do |s|
        s.collection :newspaper_articles, :class_name => 'Newspaperarticle', :date_style => :date
        s.collection :popular_science_works, :class_name => 'Genericwork', :scope => :popular_science
      end

      create_section :outreach_activities do |s|
        s.collection :professor_advices, :class_name => 'Indivadvice', :scope => :professors
        s.collection :institutional_advices, :class_name => 'Instadvice'
        s.collection :outreach_works, :class_name => 'Genericwork', :scope => :outreach_works
      end

      create_section :teaching do |s|
        s.collection :other_teaching_activities, :class_name => 'Activity', :scope => :teaching
        s.collection :student_advices, :class_name => 'Indivadvice', :scope => :students
        s.collection :teaching_products, :class_name => 'Genericwork', :scope => :teaching_products
      end

      create_section :tech_activities do |s|
        s.collection :technical_activities, :class_name => 'Activity', :scope => :technical
        #s.collection :technical_products, :class_name => 'Techproduct'
      end

      create_section :others do |s|
        s.collection :other_activities, :class_name => 'Activity', :scope => :other
        s.collection :other_works, :class_name => 'Genericwork', :scope => :other_works
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
      if subsection.date_style == :date_disabled
        subsection.all
      else
        subsection.search(date_options(subsection).merge @attributes)
      end
    end

    def extract_options(attributes)
      attributes.delete :start_date
      attributes.delete :end_date
      attributes
    end

    def date_options(subsection)
      self.send subsection.date_style
    end

    def date
      # Define the scope between in your model, for example: app/models/newspaperarticle
      { :between => [start_date, end_date] }
    end

    def month_and_year
       { :since => [ start_date.year, start_date.month ], :until => [ end_date.year, end_date.month ] }
    end

    def only_year
      { :between => [start_date.year, end_date.year] }
    end

    def date_range
       { :since =>  start_date, :until => end_date }
    end

    def start_date
       Date.parse(@start_date) or (Date.today - 1)
    end

    def end_date
      Date.parse(@end_date) or Date.today
    end
  end
end
