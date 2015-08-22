require 'test_helper'

class HetchyTest < Minitest::Test

  def test_count
    reservoir = Hetchy.new(size: 10)
    assert_equal 0, reservoir.count

    10.times do
      reservoir << rand(1000)
    end
    assert_equal 10, reservoir.count
  end

  def test_size
    reservoir = Hetchy.new(size: 5)
    assert_equal 5, reservoir.size
  end

  def test_thread_safety
    # TODO
  end

end