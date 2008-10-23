require File.dirname(__FILE__) + '/../test_helper'
class UserArticleTest < ActiveSupport::TestCase

  def test_act_as_dependent_mapper
    @user_article = UserArticle.new
    assert_equal '', @user_article.sequence
  end
end
