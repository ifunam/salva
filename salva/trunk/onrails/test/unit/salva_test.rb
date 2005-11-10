require File.dirname(__FILE__) + '/../test_helper'

class SalvaTest < Test::Unit::TestCase
  fixtures :salvas

  def setup
    @salva = Salva.find(1)
  end

  # Replace this with your real tests.
  def test_truth
    assert_kind_of Salva,  @salva
  end
end
