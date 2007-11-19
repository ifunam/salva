require 'yaml'
require 'tree'
require 'finder'
require 'user_report_html_transformer'
require 'user_report_pdf_transformer'
class UserReport
  attr_accessor :report_path
  attr_accessor :report

  def initialize(user_id,report='user_annual_report.yml')
    @user = User.find(user_id)
    @report_path = RAILS_ROOT + '/config/'
    @report = report
  end

  def build_profile(file='user_profile.yml')
    load_yml(file).collect { |h| [h.keys.first, eval_query(h.values.first)] }
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
        result = eval_query "Finder.new(#{child.data.values.first}).as_text"
        section << { :title => k, :data => result, :level => child.path.size } if !result.nil? and result.is_a? Array and result.size > 0
       else
        section += build_section(child)
      end
    end
    section.unshift({ :title => tree.data, :level => tree.path.size }) if section.size > 0 and tree.path.size > 0
    section
  end

  def as_html
    @transformer = UserReportHtmlTransformer.new
    @transformer.as_html([{ :title => 'general', :data => build_profile, :level => 1 }] + build_report)
  end

  def as_pdf(report_code)
    @transformer = UserReportPdfTransformer.new(report_code)
    @transformer.as_pdf([{ :title => 'general', :data => build_profile, :level => 1 }] + build_report)
  end

  # private
  def load_yml(file)
    file_yml = @report_path + file
    YAML::load_file(file_yml) if File.exists?(file_yml)
  end
  
  def eval_query(query)
    begin
      return eval(query)
    rescue StandardError => bang
      return nil
    end
  end 
end

