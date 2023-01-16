require 'abstract_controller'
require 'action_view'
require File.join(Rails.root, 'lib/document', 'user_profile')
require File.join(Rails.root, 'lib/document/reporter', 'base')
require 'pry'
class UserAnnualReport < AbstractController::Base
    abstract!
    include AbstractController::Rendering
    include AbstractController::Helpers
    include AbstractController::Translation
    include AbstractController::AssetPaths
    append_view_path "app/views"

    include ActiveModel::Dirty
    include ActiveModel::Validations
    include ActiveModel::Serialization
    include ActiveModel::MassAssignmentSecurity
    # attr_accessor :user_id, :year, :remote_ip, :document_type_id, :annual_report_id
    define_attribute_methods  [:user_id, :year, :remote_ip, :document_type_id, :annual_report_id]
    validates_presence_of :user_id, :year, :remote_ip, :document_type_id, :annual_report_id
    class_attribute :_attributes, :_storage_path, :_file

    self._attributes = []
    self._storage_path = File.join(%W(#{Rails.root.to_s} public uploads annual_reports))

    def self.attributes(*names)
      # attr_accessor *names
      define_attribute_methods names
    end

    def self.create(attributes={})
      record = new(attributes)
      record.save
    end

    def initialize(attributes={})
      self.attributes=(attributes)
      self
    end

    def save
      if valid?
        build_report_sections
        data = render_to_string(:template => 'user_annual_reports/show.pdf.prawn')
        store_file(data)
        if File.exist?(self._file)
          approved_by_id = User.find(@user_id).user_incharge.nil? ? nil : User.find(@user_id).user_incharge.id
          @annual_report.deliver
          @d = Document.find_by_user_id_and_documenttype_id(@user_id, @document_type_id)
          @d.destroy unless @d.nil?
          @d = Document.create(:user_id => @user_id, :ip_address => @remote_ip,
                               :documenttype_id => @document_type_id, :file => self._file,
                               :approved_by_id => approved_by_id)
        end
      else
        return false
      end
    end

    def build_report_sections
      @annual_report = AnnualReport.find(@annual_report_id)
      @profile = UserProfile.find(@user_id)
      @report_sections = Reporter::Base.find(:user_id_eq => @user_id, :start_date => "#{@year}/01/01", :end_date => "#{@year}/12/31").all
      @stamped = true
    end

    def attributes=(hash)
      sanitize_for_mass_assignment(hash).each do |attribute, value|
        send("#{attribute}=", value)
        self._attributes << attribute
      end
    end

    def attributes
      self._attributes.inject({}) do |hash, attr|
        hash[attr.to_s] = send(attr)
        hash
      end
    end

    def store_file(data)
      path = File.join(self._storage_path, @year.to_s)
      system("mkdir -p #{path}") unless  File.directory? path
      self._file = File.join(path, "#{@profile.login}.pdf")
      new_path = Rails.root.to_s + '/app/files/'
      new_path += path[path.index('annual'),path.size]
      new_path = File.join(new_path, "/#{@profile.login}.pdf")
      File.open(self._file, 'w') do |f|
        f.write data.force_encoding('utf-8')
      end
      system("touch #{new_path}")
      system("cp #{self._file} #{new_path}")
    end

end