require "#{File.dirname(__FILE__)}/../../../test_helper"

class TestObservableDo < Minitest::Test
  def test_do_error_propagation
    expected = RuntimeError.new
    actual = nil
    assert_raises(RuntimeError) do
      Rx::Observable.raise_error(expected).do(
        ->(_) {},
        ->(_err) { actual = _err },
        -> {}
      ).subscribe
    end
    assert_equal actual, expected
  end
end
