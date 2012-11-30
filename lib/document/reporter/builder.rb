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
        s.collection :researchlines, :class_name => 'UserResearchline', :date_style => :date_disabled
        s.collection :jobpositions, :class_name => 'Jobposition', :scope => :at_unam, :date_style => :date_range
        s.collection :external_jobpositions, :class_name => 'Jobposition', :scope => :at_external_institutions, :date_style => :date_range
        s.collection :educations, :date_style => :only_year
        s.collection :projects
        s.collection :user_stimuli
        s.collection :course_attendees, :class_name => 'Course', :scope => :attendees
        s.collection :conference_attendees, :class_name => 'Conference', :scope => :attendees
        s.collection :user_schoolarships, :date_style => :date_range
        s.collection :user_prizes
        s.collection :user_credits
        s.collection :memberships, :date_style => :only_year
        s.collection :institutional_activities, :date_style => :month_and_year_range
      end

      create_section :publications do |s|
        s.collection :articles, :scope => :published
        s.collection :unpublished_articles, :class_name => 'Article', :scope => :unpublished
        s.collection :book_authors, :class_name => 'Bookedition', :scope => :authors, :date_style => :month_and_year
        s.collection :book_chapters, :class_name => 'Chapterinbook',  :date_style => :month_and_year
        s.collection :refereed_inproceedings, :class_name => 'Inproceeding', :scope => :refereed, :date_style => :only_year
        s.collection :technical_reports, :class_name => 'Genericwork', :scope => :technical_reports
        s.collection :reviews
        s.collection :unrefereed_inproceedings, :class_name => 'Inproceeding', :scope => :unrefereed, :date_style => :only_year
      end

      create_section :seminary_and_conferences do |s|
        s.collection :seminaries, :scope => :as_not_attendee
        s.collection :conference_organizers, :class_name => 'Conference', :scope => :organizers
        s.collection :conference_talks, :class_name => 'Conferencetalk', :date_style => :only_year
      end

      create_section :refereed_colaborations do |s|
        s.collection :user_refereed_journals, :date_style => :month_and_year
        s.collection :book_collaborations, :class_name => 'Bookedition', :scope => :collaborators, :date_style => :month_and_year
        s.collection :proceeding_collaborations, :class_name => 'Proceeding', :date_style => :only_year
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
        s.collection :regular_courses, :class_name => 'Regularcourse', :date_style => :date_range
        s.collection :course_instructors, :class_name => 'Course', :scope => :instructors
        s.collection :theses, :date_style => :date_range, :scope => :finished
        s.collection :theses_inprogress, :class_name => 'Thesis', :date_style => :date_range, :scope => :inprogress
        s.collection :thesis_examinations, :class_name => 'ThesisJuror', :date_style => :month_and_year, :date_style => :date_range
        s.collection :tutorial_committees, :date_style => :only_year
        s.collection :student_advices, :class_name =>  'Indivadvice', :scope => :students
        s.collection :other_teaching_activities, :class_name => 'Activity', :scope => :teaching
        s.collection :teaching_products, :class_name => 'Genericwork', :scope => :teaching_products
      end

      create_section :tech_activities do |s|
        s.collection :technical_activities, :class_name => 'Activity', :scope => :technical
        s.collection :technical_products, :class_name => 'Techproduct', :date_style => :only_year
      end

      create_section :others do |s|
        s.collection :popular_science_activities, :class_name => 'Activity', :scope => :popular_science
        s.collection :academic_exchanges, :class_name => 'Acadvisit'
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
