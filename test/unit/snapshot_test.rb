require 'test_helper'

class SnapshotTest < Minitest::Test

  def test_data_sort
    snapshot = Hetchy::Snapshot.new([5,2,3,1])
    assert_equal [1,2,3,5], snapshot.data, 'data is sorted'
  end

end