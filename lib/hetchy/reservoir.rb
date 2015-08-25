module Hetchy
  class Reservoir

    attr_reader :count,     # number of samples processed
                :pool,      # raw pool data, do not modify this
                :size       # size of allocated pool

    # Create a reservoir.
    # @option opts [Integer] :size Size of reservoir
    #
    def initialize(opts={})
      @size = opts.fetch(:size, 1000)
      @lock = Mutex.new
      initialize_pool
    end

    # Add one or more values to the reservoir.
    # @example
    #   reservoir << 1234
    #   reservoir << [2345,7891,2131]
    #
    def << (values)
      Array(values).each do |value|
        @lock.synchronize do
          # sampling strategy is Vitter's algo R
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

    # Empty/reset the reservoir
    def clear
      initialize_pool
    end

    # Calculate a percentile based on the current state of the
    # reservoir.
    #
    # If you are going to calculate multiple percentiles
    # it will be faster to #snapshot and then calculate them off of
    # the generated Dataset.
    def percentile(perc)
      snapshot.percentile(perc)
    end

    # Capture a moment in time for the reservoir for analysis.
    # Since sampling may be ongoing this ensures we are working
    # with data from our intended period.
    #
    def snapshot
      data = nil
      @lock.synchronize { data = @pool.dup }
      Dataset.new(data.compact)
    end

    private

    def initialize_pool
      @lock.synchronize { @pool = Array.new(@size) }
      @count = 0
    end

  end
end