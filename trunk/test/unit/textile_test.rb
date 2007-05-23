require File.dirname(__FILE__) + '/../test_helper'
require 'textile'

class TextileTest < Test::Unit::TestCase
  include Textile
  def  test_should_get_bold_in_plain_text
    assert_equal "hello", bold('hello')
  end

  def  test_should_get_bold_in_html
    assert_equal "<p><strong>hello</strong></p>", bold('hello','html')
  end

  def  test_should_get_bold_in_pdf
    assert_equal 739.816, bold('hello','pdf')
  end

  def  test_should_get_bold_in_pdf
    assert_equal 'HELLO', header('hello')
  end

  def  test_should_get_header_in_html
    (1..3).each {| level|
      assert_equal "<h#{level}>hello</h#{level}>", header('hello', level, 'html')
    }
  end

  def  test_should_get_header_in_pdf
    assert_equal 739.816, header('hello', 1, 'pdf')
  end
end
