require "hetchy/version"

class Hetchy

  attr_reader :count,     # number of samples processed
              :pool,      # current pool data
              :size       # size of allocated pool

  # Available opts:
  # @option opts [Integer] :size Size of reservoir
  #
  def initialize(opts={})
    @count = 0
    @size = opts.fetch(:size, 1024)
    @pool = Array.new(@size, 0)
    @lock = Mutex.new
  end

  # Add one or more values to the reservoir
  # @example
  #   reservoir << 1234
  #   reservoir << [2345,7891,2131]
  #
  def << (values)
    Array(values).each do |value|
      @lock.synchronize do
        if count < size
          @pool[count] = value
        else
          index = rand(count+1)
          if index < @size
            @pool[index] = value
          end
        end
        @count += 1
      end
    end
  end

end
