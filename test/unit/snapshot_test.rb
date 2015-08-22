require 'test_helper'

class SnapshotTest < Minitest::Test

  def test_data_sort
    snapshot = Hetchy::Snapshot.new([5,2,3,1])
    assert_equal [1,2,3,5], snapshot.data, 'data is sorted'
  end

  def test_percentile

  end

  def test_percentile_limits
    snapshot = Hetchy::Snapshot.new([1,2,3])
    assert_raises(Hetchy::InvalidPercentile) { snapshot.percentile(-0.2) }
    assert_raises(Hetchy::InvalidPercentile) { snapshot.percentile(1000) }
  end

  def test_size
    snapshot = Hetchy::Snapshot.new([1,2,3])
    assert_equal 3, snapshot.size
  end

end