require File.dirname(__FILE__) + '/../test_helper'
require 'textile'

class TextileTest < Test::Unit::TestCase
  include Textile
  def  test_should_get_bold_plain_text
    assert_equal "hello", bold('hello')
  end

  def  test_should_get_bold_html
    assert_equal "<p><strong>hello</strong></p>", bold('hello','html')
    end

    def  test_should_get_bold_pdf
      assert_equal 739.816, bold('hello','pdf')
    end
end
