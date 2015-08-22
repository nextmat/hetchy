require 'test_helper'

class HetchyTest < Minitest::Test

  def test_add_basics
    # single add
    reservoir = Hetchy.new(size: 10)
    reservoir << 1
    assert_equal 1, reservoir.pool[0]

    # multi add
    reservoir << [2,3,4]
    assert_equal 2, reservoir.pool[1]
    assert_equal 3, reservoir.pool[2]
    assert_equal 4, reservoir.pool[3]
  end

  def test_add_pool_fully_accessible
    series = Array(1..1000)
    reservoir = Hetchy.new(size: 10)
    reservoir << series

    refute_equal 1, reservoir.pool[0], 'first entry in pool can be changed'
    refute_equal 10, reservoir.pool[-1], 'last entry in pool can be changed'
  end

  def test_add_saturation_starts_sampling
    series = Array(1..15)
    overflow = series[10..-1]

    reservoir = Hetchy.new(size: 10)
    reservoir << series

    assert_equal 15, reservoir.count, 'all samples recorded'
    assert_equal 10, reservoir.pool.length, 'pool is stable size'
    refute_equal (series - reservoir.pool), overflow,
      'overflow measures are sampled into pool'
  end

  def test_add_thread_safety
    reservoir = Hetchy.new(size: 1024)
    threads = []
    5.times do
      threads << Thread.new do
        1000.times { reservoir << rand(10000) }
      end
    end

    threads.each(&:join)
    assert_equal 5000, reservoir.count, 'adding is threadsafe'
  end

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

  def test_snapshot
    reservoir = Hetchy.new(size: 5)
    reservoir << [1,2]
    snapshot = reservoir.snapshot

    reservoir << 3
    assert_includes snapshot.data, 1, 'has previous samples'
    assert_includes snapshot.data, 2, 'has previous samples'
    refute_includes snapshot.data, 3, 'does not receive changes'
  end

end