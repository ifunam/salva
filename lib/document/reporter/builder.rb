require 'document/reporter/section'
module Reporter
  class Builder

    def initialize
      @body = Section.new
    end

    def sections
      build_sections
      @body.sections
    end

    private
    def build_sections
      create_section :profile do |s|
        s.collection :user_stimuli
        s.collection :course_attendees, :class_name => 'Course', :scope => :attendees
        s.collection :conference_attendees, :class_name => 'Conference', :scope => :attendees
        s.collection :user_schoolarships, :date_style => :date_range
        s.collection :user_credits
        s.collection :institutional_activities
      end

      create_section :seminary_and_conferences do |s|
        s.collection :seminaries, :scope => :as_not_attendee
        s.collection :conference_organizers, :class_name => 'Conference', :scope => :organizers

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
        s.collection :course_instructors, :class_name => 'Course', :scope => :instructors
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

    def create_section(title)
      section = Section.new(title)
      yield section if block_given?
      @body.add_child(section)
    end
  end
end