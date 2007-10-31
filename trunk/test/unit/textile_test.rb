require File.dirname(__FILE__) + '/../test_helper'
require 'textile'

class TextileTest < Test::Unit::TestCase
  include Textile
  def  test_should_get_bold_in_plain_text
    assert_equal "hello", bold('hello')
  end

  def  test_should_get_bold_in_html
    assert_equal "<b>hello</b>", bold('hello','html')
  end

  def  test_should_get_bold_in_plain_text
    assert_equal 'HELLO', header('hello')
  end

  def  test_should_get_header_in_html
    (1..3).each {| level|
      assert_equal "<h#{level}>hello</h#{level}>", header('hello', level, 'html')
    }
  end

  def test_should_get_paragragh
    assert_equal "<p>HELLO</p>", paragraph('HELLO')
    assert_equal "<p>hello</p>", paragraph('hello')
    assert_equal "<p><b>hello</b></p>", paragraph(bold('hello','html'))
  end

  def test_should_get_internal_link
    assert_equal "<a name=\"profile\"></a>", internal_link('profile')
  end

  def test_should_get_link_to_internal
      assert_equal "<a href=\"#profile\">Perfil</a>", link_to_internal('profile', 'Perfil')
  end
end
