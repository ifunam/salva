module SuperCatalog
  module Generators
    class ControllerGenerator < Rails::Generators::NamedBase
      argument :actions, :type => :array, :default => [], :banner => "action action"
      check_class_collision :suffix => "Controller"

      source_root File.expand_path("../templates", __FILE__)

      desc "Generates a controller and routes under the admin namespace with the given NAME (if one does not exist) " <<
           "based on Admin::SuperCatalogController class." 

      def create_controller_files
        template 'controller.rb', File.join('app/controllers', class_path, "#{file_name}_controller.rb")
      end

      def add_routes
        actions.reverse.each do |action|
          route %{get "#{file_name}/#{action}"}
        end
      end
      hook_for :template_engine, :test_framework
    end
  end
end
