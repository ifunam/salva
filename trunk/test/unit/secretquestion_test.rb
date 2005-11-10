require File.dirname(__FILE__) + '/../test_helper'

class SecretquestionTest < Test::Unit::TestCase
  fixtures :secretquestion

  def setup
    @secretquestion = Secretquestion.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Secretquestion,  @secretquestion
  end
end
