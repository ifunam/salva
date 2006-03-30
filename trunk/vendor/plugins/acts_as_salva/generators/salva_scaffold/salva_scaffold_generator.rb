class ScaffoldingSandbox
  attr_accessor :form_action, :singular_name, :suffix, :model_instance
  def sandbox_binding
    binding
  end

  def salva_tags (model_instance, singular_name)
    attrs = model_instance.attributes()
    html = "\n"
    hidden = %w( id moduser_id user_id dbtime updated_on created_on)
    tabindex = 1
    attrs.each_key { | column | 
      next if hidden.include? column
      html << "<div class=\"row\"> \n"
      # Check the documentation for ActiveRecord::ConnectionAdapters::Column
      if model_instance.column_for_attribute(column).null then
        html << "<label for=\"#{column}\" class=\"label\"><%= get_label('#{column}') %></label> \n"
      else
        html << "<label for=\"#{column}\" class=\"label\"><%= get_label('#{column}') %> <span class=\"required\">*</span></label> \n"
      end
      if column =~ /_id$/ then
        model_select = column.sub(/_id/,'') 
        if model_select =~ /^\w+_/ then
          (prefix, model_select) = model_select.split('_')
	  model_select = Inflector.camelize(model_select)
          html << "<div id=\"#{column}\">\n" 
          html << "<%= table_select('edit', #{model_select}, {:prefix => '#{prefix}', :tabindex => '#{tabindex}'}) %>\n" 
          html << "<%= quickpost('#{model_select}') %> \n"
          html << "</div>\n"
        else
	  model_select = Inflector.camelize(model_select)
          html << "<div id=\"#{column}\">\n"
          html << "<%= table_select('edit', #{model_select}, {:tabindex => '#{tabindex}'}) %> \n" 
          html << "<%= quickpost('#{model_select}') %> \n"
          html << "</div>\n"
        end
      elsif column =~ /month/ then
        html << "<%= month_select('edit', '#{column}', {:tabindex => '#{tabindex}'}) %> \n"
      elsif column =~ /year/ then
        html << "<%= year_select('edit', '#{column}', {:tabindex => '#{tabindex}'}) %> \n"
      else
        html << "<%= text_field 'edit', '#{column}', 'size' => 30, 'maxsize'=> 40,'tabindex'=> #{tabindex}, 'id' => '#{column}' %>\n"  
      end
      html << "</div>\n\n"
      tabindex += 1
    }
    html
  end

  def salva_model (model_instance, singular_name)
    attrs = model_instance.attributes()
    required = []
    numeric = []
    belongs_to = []
    hidden = %w( id moduser_id user_id dbtime updated_on created_on)
    attrs.each_key { | column | 
      next if hidden.include? column
      if column =~ /_id$/ then
        numeric << ':'+column
        required << ':'+column if !model_instance.column_for_attribute(column).null
        refmodel = column.sub(/_id/,'') 
        if refmodel =~ /^\w+_/ then
          (prefix, model) = refmodel.split('_')
          belongs_to << [ refmodel, Inflector.camelize(model), column ]
        else
          belongs_to << [ refmodel ]
        end
      else
        required << ':'+column if !model_instance.column_for_attribute(column).null
      end
    }
    classmodel = 'validates_presence_of ' + required.join(', ') + "\n"
    classmodel += 'validates_numericality_of ' + numeric.join(', ') + "\n" 
    belongs_to.each { | params |
      if params.length > 1 then
        classmodel += "belongs_to :" + params[0].to_s + ", :class_name => '" + params[1].to_s + "', :foreign_key => '" + params[2].to_s + "'\n"
      else 
        classmodel += "belongs_to :" + params[0].to_s + "\n"
      end
    }
    classmodel
  end
end  

class SalvaScaffoldGenerator < Rails::Generator::NamedBase
  attr_reader   :controller_name,
                :controller_class_path,
                :controller_file_path,
                :controller_class_nesting,
                :controller_class_nesting_depth,
                :controller_class_name,
                :controller_singular_name,
                :controller_plural_name
  alias_method  :controller_file_name,  :controller_singular_name
  alias_method  :controller_table_name, :controller_plural_name
  
  def initialize(runtime_args, runtime_options = {})
    super

    # Take controller name from the next argument.  Default to the pluralized model name.
    @controller_name = args.shift
    @controller_name ||= @name #ActiveRecord::Base.pluralize_table_names ? @name.pluralize : 
    
    base_name, @controller_class_path, @controller_file_path, @controller_class_nesting, @controller_class_nesting_depth = extract_modules(@controller_name)
    @controller_class_name_without_nesting, @controller_singular_name, @controller_plural_name = inflect_names(base_name)

    if @controller_class_nesting.empty?
      @controller_class_name = @controller_class_name_without_nesting
    else
      @controller_class_name = "#{@controller_class_nesting}::#{@controller_class_name_without_nesting}"
    end
  end


  def manifest
    record do |m|
      # Check for class naming collisions.
      m.class_collisions controller_class_path, "#{controller_class_name}Controller", 
                                                #"#{controller_class_name}ControllerTest", 
                                                "#{controller_class_name}Helper"
      m.class_collisions class_path,            "#{class_name}"
                                                #"#{class_name}Test"


      # Controller, helper, views, and test directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('app/controllers', controller_class_path)
      m.directory File.join('app/helpers', controller_class_path)
      m.directory File.join('app/views', controller_class_path, controller_file_name)
      m.directory File.join('test/functional', controller_class_path)
      m.directory File.join('test/unit', class_path)

      # Scaffolded models.
        m.complex_template "model_salva.rb",
        File.join('app/models',
                  class_path,
                  "#{file_name}.rb"),
        :insert => 'model_scaffolding.rb',
        :sandbox => lambda { create_sandbox },
        :begin_mark => 'salva_model',
        :end_mark => 'eof_salva_model'
#        :mark_id => singular_name


      m.template 'controller.rb',
                  File.join('app/controllers',
                            controller_class_path,
                            "#{controller_file_name}_controller.rb")

      m.template 'functional_test.rb',
                  File.join('test/functional',
                            controller_class_path,
                            "#{controller_file_name}_controller_test.rb")

      m.template 'helper.rb',
                  File.join('app/helpers',
                            controller_class_path,
                            "#{controller_file_name}_helper.rb")

      m.template 'unit_test.rb',
                  File.join('test/unit',
                            class_path,
                            "#{file_name}_test.rb")

      # Scaffolded forms.
        m.complex_template "form.rhtml",
        File.join('app/views',
                  controller_class_path,
                  controller_file_name,
                  "_form.rhtml"),
        :insert => 'form_scaffolding.rhtml',
        :sandbox => lambda { create_sandbox },
        :begin_mark => 'form',
        :end_mark => 'eoform',
        :mark_id => singular_name

      # Scaffolded views and partials.
      %w(list show _show new edit).each do |action|
                              m.template "view_#{action}.rhtml",
                   File.join('app/views',
                             controller_class_path,
                             controller_file_name,
                             "#{action}.rhtml"),
                              :assigns => { :action => action }
                            end
                            
                          end
                        end

  protected
    # Override with your own usage banner.
    def banner
      "Usage: #{$0} salva_scaffold ModelName [ControllerName]"
    end
    
    def model_name
      class_name.demodulize
    end
    
    def unscaffolded_actions
      args - scaffold_actions
    end

    def suffix
      "_#{singular_name}" if options[:suffix]
    end
    

    def create_sandbox
      sandbox = ScaffoldingSandbox.new
      sandbox.singular_name = singular_name
      sandbox.model_instance = model_instance
      sandbox.instance_variable_set("@#{singular_name}", sandbox.model_instance)
      sandbox.suffix = suffix
      sandbox
    end
    
    def model_instance
       base = class_nesting.split('::').inject(Object) do |base, nested|
         break base.const_get(nested) if base.const_defined?(nested)
         base.const_set(nested, Module.new)
       end
       unless base.const_defined?(@class_name_without_nesting)
         base.const_set(@class_name_without_nesting, Class.new(ActiveRecord::Base))
       end
      class_name.constantize.new
    end
end
