require File.dirname(__FILE__) + '/spec_helper'
require 'minimal'
module ViewsSpecHelper

  alias :require_dependency :require
  Minimal::Template.send(:include, Minimal::Template::FormBuilderProxy)
  ActionView::Template.register_template_handler(:rb, Minimal::Template::Handler)
  ActionView::Base.class_eval { def protect_against_forgery?; false end }
  
  FIXTURES_PATH = File.join(Rails.root, 'app/views')
  Dir["#{File.dirname(__FILE__)}/../app/views/**/*.rb"].each {|f| require f}

  def setup
    @view = @template = nil
  end

  def view
    @view ||= ActionView::Base.new(FIXTURES_PATH).tap do |view|
      view.output_buffer = ActiveSupport::SafeBuffer.new
    end
  end

  def template
    @template ||= Minimal::Template.new(view)
  end
end
include ViewsSpecHelper