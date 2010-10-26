require 'rails/generators/named_base'
require 'rails/generators/erb'
require 'rails/generators/resource_helpers'
require File.expand_path("../generated_attribute", __FILE__)
module SuperCatalog
  module Generators
    class ViewsGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers
      desc "Copies all SuperCatalog views to your application."
      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      source_root File.expand_path("../templates", __FILE__)
      
      def create_view_files
         verify_haml_existence
         engine = options[:template_engine]
         Dir["#{self.class.source_root}/*"].each do |path|
           view = File.basename(path)
           if view == '_record.html.haml'
             template path,  "app/views/#{class_path}/#{plural_name}/_#{singular_name}.html.haml"
           else
             template path,  "app/views/#{class_path}/#{plural_name}/#{view}"
           end
         end
      end
      
      protected
      def verify_haml_existence
         begin
           require 'haml'
         rescue LoadError
           say "HAML is not installed, or it is not specified in your Gemfile."
           exit
         end
      end
    end
  end
end