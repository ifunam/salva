require 'yaml'
require 'tree'
require 'finder'

class UserReport
  attr_accessor :report_path
  
  def initialize(id)
    @user = User.find(id)
    @report_path = RAILS_ROOT + '/config/'
  end

  def build_profile(file='user_profile.yml')
    profile = load_yml(file)
    profile.keys.inject({}) { |h,k| h[k] = eval profile[k]; h } if profile.is_a? Hash
  end
  
  def build_report(file='user_annual_report.yml')
    tree = Tree.new(load_yml(file))
    tree.data = file.sub(/\.yml$/,'')
    build_section(tree)
  end
  
  def build_section(tree)
    section = [ ]
    tree.children.each do | child |
      if child.is_leaf?
        k = child.data.keys.first
        result = eval child.data.values.first
        section << { :title => k, :data =>  result, :level => child.path.size } if !result.nil? and result.is_a? Array and result.size > 0
       else
        section += build_section(child)
      end
    end
    section
  end
  
  #  private
  def load_yml(file)
    file_yml = @report_path + file
    YAML::load_file(file_yml) if File.exists?(file_yml)
  end
end
