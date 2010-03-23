require 'minimal'
Minimal::Template.send(:include, Minimal::Template::FormBuilderProxy)
ActionView::Template.register_template_handler(:rb, Minimal::Template::Handler)
ActionView::Base.class_eval { def protect_against_forgery?; false end }
