require 'yaml'
require 'tree'
require 'finder'
class UserReport
  attr_accessor :report_path
  attr_accessor :report

  def initialize(id,report='user_annual_report.yml')
    @user = User.find(id)
    @report_path = RAILS_ROOT + '/config/'
    @report = report
#    @transformer = UserReportTransformer.new
  end

  def build_profile(file='user_profile.yml')
    load_yml(file).collect { |h| [h.keys.first, (eval h.values.first)] }
  end

  def build_report
    tree = Tree.new(load_yml(@report))
    build_section(tree)
  end

  def build_section(tree)
    section = [ ]
    tree.children.each do | child |
      if child.is_leaf?
        k = child.data.keys.first
        result = eval child.data.values.first
        section << { :title => k, :data => result, :level => child.path.size } if !result.nil? and result.is_a? Array and result.size > 0
       else
        section += build_section(child)
      end
    end
    section.unshift({ :title => tree.data, :level => tree.path.size }) if section.size > 0 and tree.path.size > 0
    section
  end

  def as_html
    @data = [{ :title => 'general', :data => build_profile, :level => 1 }] + build_report
#    @transformer.as_html(@data)
    @data
  end

#  def as_text
#    @transformer.as_text(@data)
#  end

#  def as_pdf
#    @transformer.as_pdf(@data)
#  end

  # private
  def load_yml(file)
    file_yml = @report_path + file
    YAML::load_file(file_yml) if File.exists?(file_yml)
  end
end
