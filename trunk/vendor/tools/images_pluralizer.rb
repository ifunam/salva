RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../../config/environment'
require 'yaml'

def tree_image_pluralizer(tree)
  tree.collect  { |child|
    if child.is_a? Array
      if child.size == child.flatten.size
        tree_image_pluralizer(child)
       else
         parent = child.shift
        tree_image_pluralizer(child)
      end
    else
      orig = RAILS_ROOT + '/public/images/' + child + '.png'
      new = RAILS_ROOT + '/public/images/' + Inflector.pluralize(child)   + '.png'
      File.rename(orig, new) if File.exists? orig
#      puts orig, new if File.exists? orig
    end
    }
end

filename = 'researcher'
file  = "#{RAILS_ROOT}/config/tree/#{filename}.yml"
if File.exists? file
  tree = YAML::load_file(file)
  tree_image_pluralizer([filename, tree])
end
