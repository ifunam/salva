class ScaffoldingSandbox
  attr_accessor :form_action, :singular_name, :suffix, :model_instance
  def sandbox_binding
    binding
  end

  def set_label(column, required=nil)
    if required then
      "<label for=\"#{column}\" class=\"label\"><%= get_label('#{column}') %> <span class=\"required\">*</span></label> \n"
    else
      "<label for=\"#{column}\" class=\"label\"><%= get_label('#{column}') %></label> \n"
    end
  end

  def set_textfield(column, tabindex, required=nil)
    if required then
      "<%= text_field 'edit', '#{column}', 'size' => 30, 'maxlength'=> 40, 'tabindex'=> #{tabindex}, 'id' => '#{column}' %>\n"
    else
      "<%= text_field 'edit', '#{column}', 'size' => 30, 'maxlength'=> 40, 'tabindex'=> #{tabindex}, 'id' => '#{column}' %>\n"
    end
  end


  def set_radiobutton(column, tabindex, required=nil)
    radio = "<div class=\"radio\"> \n"
    radio << "No <%= radio_button('edit', '#{column}', 'false') %>\n"
    radio << "Sí <%= radio_button('edit', '#{column}', 'true') %> \n"
    radio << "</div>\n"
  end

  def set_textarea(column, tabindex, required=nil)
    if required then
      "<%= text_area 'edit', '#{column}', 'rows' => 4, 'cols' => 40, 'tabindex' => #{tabindex}, 'id' => '#{column}' %>\n"
    else
      "<%= text_area 'edit', '#{column}', 'rows' => 4, 'cols' => 40, 'tabindex' => #{tabindex}, 'id' => '#{column}' %>"
    end
  end

  def set_select(column, model, tabindex, required=nil, prefix=nil)
    options = tabindex.to_i.to_s
    options << ", '#{prefix}'" if prefix
    select = "<div id=\"#{column}\">\n"
    select << "<%= simple_select('edit', #{Inflector.camelize(model)}, #{options}) %>\n"
    select << "</div>\n"
  end

  def set_month(column, tabindex, required=nil)
    required ? req = 1 : req = 0
    "<%= month_select('edit', '#{column}', {:tabindex => #{tabindex}, :required => #{req} }) %> \n"
  end

  def set_year(column, tabindex, required=nil)
    if required != nil
      "<%= text_field_with_auto_complete :edit, :#{column}, {:size =>4, :maxlength =>4, :tabindex => #{tabindex}}, :skip_style => true %><br/>"
    else
      "<%= text_field_with_auto_complete :edit, :#{column}, {:size =>4, :maxlength =>4, :tabindex => #{tabindex}}, :skip_style => true %><br/>"
    end
  end

  def get_tableattr(model_instance, singular_name)
    table_name =  Inflector.tableize(model_instance.class.name)
    attrs = model_instance.connection.columns(table_name)
    [table_name, attrs]
  end

  def salva_tags (model_instance, singular_name)
    (table_name, attrs) = get_tableattr(model_instance, singular_name)
    hidden = %w( id moduser_id user_id dbtime updated_on created_on)
    html = ""
    tabindex = 1
    attrs.each { | attr |
      column = attr.name
      next if hidden.include? column
      html << "<div class=\"row\"> \n"
      model_instance.column_for_attribute(column).null ? required = nil : required = 1
      html << set_label(column, required)

      if column =~ /_id$/ then
        prefix = nil
        model = column.sub(/_id/,'')
        (prefix, model) = model.split('_') if model =~ /^\w+_/
        html << set_select(column, model, tabindex, required, prefix)
      elsif model_instance.column_for_attribute(column).type.to_s == 'boolean' then
        html << set_radiobutton(column, tabindex, required)
      elsif column =~ /month/ then
        html << set_month(column, tabindex, required)
      elsif column =~ /year/ then
        html << set_year(column, tabindex, required)
      elsif column =~/other/ or column =~/descr/ or column =~/comment/ or column =~/author/  or column =~/title/ then
        html << set_textarea(column, tabindex, required)
      else
        html << set_textfield(column, tabindex, required)
      end
      html << "</div>\n\n" #</div class="row">
      tabindex += 1
    }
    html
  end

  def set_attrs(model_instance, attrs)
    hidden = %w( id moduser_id user_id dbtime updated_on created_on)
    required = []
    numeric = []
    belongs_to = []

    attrs.each { | attr |
      column = attr.name
      next if hidden.include? column
      if column =~ /_id$/ then
        numeric << column
        if !model_instance.column_for_attribute(column).null
          required << column
        end
        refmodel = column.sub(/_id/,'')
        if refmodel =~ /^\w+_/ then
          (prefix, model) = refmodel.split('_')
          belongs_to << [ refmodel, Inflector.camelize(model), column ]
        else
          belongs_to << refmodel
        end
      else
        if !model_instance.column_for_attribute(column).null
          required << column
        end
      end
    }
    [required, numeric, belongs_to]
  end

  def set_attrmodel(attrs)
    attrs.map{ |attr| ':'+ attr}.join(', ') + "\n"
  end

  def set_classmodel(required=[], numeric=[], belongs_to=[])
    classmodel = ''
    if required.length > 0
      classmodel = "validates_presence_of " + set_attrmodel(required)
    end

    if numeric.length > 0
      classmodel += "validates_numericality_of " + set_attrmodel(numeric)
    end
    belongs_to.each { | params |
      if params.is_a? Array then
        classmodel += "belongs_to :" + params[0].to_s + ", :class_name => '"\
        + params[1].to_s + "', :foreign_key => '" + params[2].to_s + "'\n"
      else
        classmodel += "belongs_to :" + params + "\n"
      end
    }
    classmodel
  end

  def salva_model (model_instance, singular_name)
    (table_name, attrs) = get_tableattr(model_instance, singular_name)
    (required, numeric, belongs_to) = set_attrs(model_instance, attrs)
    set_classmodel(required, numeric, belongs_to)
  end

  def view_list (model_instance, singular_name)
    (table_name, attrs) = get_tableattr(model_instance, singular_name)
    (required, numeric, belongs_to) = set_attrs(model_instance, attrs)
    required.join(' ')
  end

  def get_moduser(model_instance, singular_name)
    (table_name, attrs) = get_tableattr(model_instance, singular_name)
    moduser_attrs = %w(moduser_id updated_on created_on)
    columns = []
    attrs.each { | attr |
      columns << attr.name if moduser_attrs.include? attr.name
    }
    columns
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

      # Controller, views, and test directories.
      m.directory File.join('app/models', class_path)
      m.directory File.join('app/controllers', controller_class_path)
      m.directory File.join('app/views', controller_class_path,
                            controller_file_name)
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
        :end_mark => 'salva_model'

      m.template 'controller.rb',
                  File.join('app/controllers',
                            controller_class_path,
                            "#{controller_file_name}_controller.rb")

      print "="*80, "\n"
      puts m.class.name
      m.template 'functional_test.rb',
                  File.join('test/functional',
                            controller_class_path,
                            "#{controller_file_name}_controller_test.rb")

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

         m.complex_template "list.rhtml",
         File.join('app/views',
                   controller_class_path,
                   controller_file_name,
                   "list.rhtml"),
         :insert => 'list_scaffolding.rhtml',
         :sandbox => lambda { create_sandbox },
         :begin_mark => 'list',
         :end_mark => 'eoflist',
         :mark_id => singular_name

         m.complex_template "show.rhtml",
         File.join('app/views',
                   controller_class_path,
                   controller_file_name,
                   "show.rhtml"),
         :insert => 'show_scaffolding.rhtml',
         :sandbox => lambda { create_sandbox },
         :begin_mark => 'show',
         :end_mark => 'eofshow',
         :mark_id => singular_name

      # Scaffolded views and partials.
      %w(_show new edit).each do |action|
                              m.template "view_#{action}.rhtml",
                   File.join('app/views',
                             controller_class_path,
                             controller_file_name,
                             "#{action}.rhtml"),
                              :assigns => { :action => action }
       end

       m.clean_model
    end
  end

  def clean_model
    modelfh = "app/models/#{file_name}.rb"
    print "Cleaning dirty comments in: #{modelfh} ...\n"
    File.open(modelfh, 'r+') do |f|
      out = ""
      f.each do |line|
        out << line if line !~ /salva_model/ and line.length > 1
      end
      f.pos = 0
      f.print out
      f.truncate(f.pos)
    end
    print "OK\n"
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
      sandbox.instance_variable_set("@#{singular_name}",
                                    sandbox.model_instance)
      sandbox.suffix = suffix
      sandbox
    end

    def model_instance
      base = class_nesting.split('::').inject(Object) do |base, nested|
        break base.const_get(nested) if base.const_defined?(nested)
        print "nested #{nested}\n"
        base.const_set(nested, Module.new)
      end
      unless base.const_defined?(@class_name_without_nesting)
        base.const_set(@class_name_without_nesting,
                       Class.new(ActiveRecord::Base))
      end
      class_name.constantize.new
    end

  end



