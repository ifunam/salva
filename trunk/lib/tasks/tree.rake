ENV["RAILS_ENV"] ||= "production"
require File.expand_path(File.dirname(__FILE__) + "/../../config/environment")
require 'yaml'
namespace :db do

  desc "Load tree into current environment (see RAILS_ROOT/tree/filename.yml)"
  task "tree:load" do
    filename = ENV['tree'] || 'default'
    file  = "#{RAILS_ROOT}/config/tree/#{filename}.yml"
    db    = ENV['DB']   || 'production'
    if File.exists? file
      tree = YAML::load_file(file)
      tree_loader([filename, tree])
    else
      p "You should put your yaml tree into #{RAILS_ROOT}/config/tree/ directory"
    end
   end

  desc "Delete specific tree from current environment..."
  task "tree:delete" do
    tree = ENV['tree']
    require 'tree'
    Menu.find_by_data(tree).destroy unless tree.nil?
  end

  private
  def tree_loader(tree, parent_id=nil)
    prev_id = nil
    tree.each  do |child|
      if child.is_a? Array
        tree_loader(child, prev_id)
      else
        require 'menu'
        @t = Menu.new({:data => child})
        @t.save
        @t.move_to_child_of parent_id if parent_id != nil
        prev_id = @t.id
      end
    end
  end

end
