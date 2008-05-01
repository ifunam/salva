
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
      orig_image = child + '.png'
      orig = RAILS_ROOT + '/public/images/' + orig_image
      new_image = Inflector.pluralize(child)   + '.png'
      new = RAILS_ROOT + '/public/images/' +  new_image
      `cd #{RAILS_ROOT + '/public/images/'} && git mv #{orig_image} #{new_image}` if File.exists? orig and !File.exists? new
    end
    }

end

filename = 'researcher'
file  = "#{RAILS_ROOT}/config/tree/#{filename}.yml"
if File.exists? file
  tree = YAML::load_file(file)
  tree_image_pluralizer([filename, tree])
end
