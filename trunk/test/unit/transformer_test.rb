require File.dirname(__FILE__) + '/../test_helper'
require 'transformer'
require 'yaml'
class TransformerTest < Test::Unit::TestCase
 def  setup
   @transformer = Transformer.new
   file =  File.join(RAILS_ROOT, 'test/fixtures', 'transformer.yml')
   @data = YAML::parse(File.open(file))
 end

  def test_should_transform_data_to_text
    file_content = File.open(File.join(RAILS_ROOT, 'test/fixtures', 'transformer_output.txt'))
    text_from_file = file_content.readlines.collect { |string|  string }
    assert_equal text_from_file.to_s,  @transformer.as_text(@data.transform)
  end

 def test_should_transform_data_to_html
   file_content = File.open(File.join(RAILS_ROOT, 'test/fixtures', 'transformer_output.html'))
   html_from_file = file_content.readlines.collect { |string|  string }
   assert_equal html_from_file.to_s,  @transformer.as_html(@data.transform)
 end

 def test_should_transform_data_to_pdf
   file_content = File.open(File.join(RAILS_ROOT, 'test/fixtures', 'transformer_output.pdf'))
   assert file_content.read, @transformer.as_pdf(@data.transform)
  end
 #    file_content = File.new File.join(RAILS_ROOT, 'test/fixtures', 'transformer_output.pdf'), 'w'
 #    file_content.write @transformer.as_pdf(@data.transform)
 #    file_content.close
end
