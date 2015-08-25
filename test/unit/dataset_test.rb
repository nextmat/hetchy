require 'test_helper'

module Hetchy
  class DatasetTest < Minitest::Test

    def test_data_sort
      dataset = Dataset.new([5,2,3,1])
      assert_equal [1,2,3,5], dataset.data, 'data is sorted'
    end

    def test_median
      dataset = Dataset.new(Array(1..10))
      assert_equal 5.5, dataset.median, 'median is accurate'
    end

    def test_percentile_empty
      empty_dataset = Dataset.new([])
      assert_equal 0.0, empty_dataset.percentile(99)
    end

    def test_percentile_limits
      dataset = Dataset.new([1,2,3])
      assert_raises(InvalidPercentile) { dataset.percentile(-0.2) }
      assert_raises(InvalidPercentile) { dataset.percentile(1000) }
    end

    def test_percentile_simple
      dataset = Dataset.new(Array(1..9))
      assert_equal 5, dataset.percentile(50)

      set = [4, 4, 5, 5, 5, 5, 6, 6, 6, 7, 7, 7, 8, 8, 9, 9, 9, 10, 10, 10]
      dataset = Dataset.new(set)
      assert_equal 5, dataset.percentile(25)
      assert_in_delta 9.85, dataset.percentile(85), 0.001
    end

    def test_size
      dataset = Dataset.new([1,2,3])
      assert_equal 3, dataset.size
    end

  end
end