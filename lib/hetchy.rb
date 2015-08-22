require "hetchy/version"

class Hetchy

  attr_reader :count,     # number of samples processed
              :pool,      # current pool data
              :size       # size of allocated pool

  # Available opts:
  # @option opts [Integer] :size Size of reservoir
  def initialize(opts={})
    @count = 0
    @size = opts.fetch(:size, 1024)
    @pool = Array.new(@size, 0)
  end

  def <<(values)
    @count += 1
  end

end
