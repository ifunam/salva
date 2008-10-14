
 require File.dirname(__FILE__) + '/../test_helper'
require 'application_helper'

class ApplicationHelperTest < ActiveSupport::TestCase
  include ApplicationHelper

  def test_get_views
    assert_equal  [["article", "published_articles"], ["user_article", "user_articles"]],
    get_views([[:published_articles, :articles], :user_articles ])
  end
end
