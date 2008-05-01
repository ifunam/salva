RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../../config/environment'
require 'yaml'

def tree_loader(tree)
  tree.collect  { |child|
    if child.is_a? Array
       if child.size == child.flatten.size
        tree_loader(child)
       else
         parent = child.shift
         tree_loader(child).unshift(parent)
      end
    else
      Inflector.pluralize(child)
    end
    }
end

filename = 'researcher'
file  = "#{RAILS_ROOT}/config/tree/#{filename}.yml"
if File.exists? file
  tree = YAML::load_file(file)
  tree_loader([filename, tree])[1].to_yaml
end
