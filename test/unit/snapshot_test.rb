require 'test_helper'

class SnapshotTest < Minitest::Test

  def test_data_sort
    snapshot = Hetchy::Snapshot.new([5,2,3,1])
    assert_equal [1,2,3,5], snapshot.data, 'data is sorted'
  end

  def test_percentile_empty
    empty_snapshot = Hetchy::Snapshot.new([])
    assert_equal 0.0, empty_snapshot.percentile(99)
  end

  def test_percentile_limits
    snapshot = Hetchy::Snapshot.new([1,2,3])
    assert_raises(Hetchy::InvalidPercentile) { snapshot.percentile(-0.2) }
    assert_raises(Hetchy::InvalidPercentile) { snapshot.percentile(1000) }
  end

  def test_percentile_simple
    snapshot = Hetchy::Snapshot.new(Array(1..9))
    assert_equal 5, snapshot.percentile(50)

    set = [4, 4, 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 10]
    snapshot = Hetchy::Snapshot.new(set)
    assert_equal 5, snapshot.percentile(25)
    assert_in_delta 9.85, snapshot.percentile(85), 0.001
  end

  def test_size
    snapshot = Hetchy::Snapshot.new([1,2,3])
    assert_equal 3, snapshot.size
  end

end