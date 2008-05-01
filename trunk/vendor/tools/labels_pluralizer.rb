RAILS_ENV = 'development'
require File.dirname(__FILE__) + '/../../config/environment'
require 'yaml'

def tree_label_pluralizer(tree)
  tree.collect  { |child|
    if child.is_a? Array
      if child.size == child.flatten.size
        tree_label_pluralizer(child)
       else
         parent = child.shift
        tree_label_pluralizer(child)
      end
    else
      orig=child
      new = Inflector.pluralize(child)
      file_label=  "#{RAILS_ROOT}/po/salva.yml"
      if File.exists? file_label
       # s/orig/new
       ###puts "#{orig}, -- #{new}"
      `perl  -p  -e 's/#{orig + ":"}/#{new + ":"}/g'  #{file_label}`
      # `ruby -pe 'gsub(/#{orig}/, "#{new}")' < #{file_label} >../../po/salva_new.yml`
      end
   end
    }
end

filename = 'default'
file  = "#{RAILS_ROOT}/config/tree/#{filename}.yml"
if File.exists? file
  tree = YAML::load_file(file)
  tree_label_pluralizer([filename, tree])
end
