class Hetchy

  # Contains reservoir data frozen in time, created by Hetchy#snapshot.
  # This class does only read-only work and should be treated as immutable.
  #
  class Snapshot

    attr_reader :data,
                :size

    def initialize(data)
      @data = data.sort
      @size = @data.length
    end

    # @return [Float/Integer] median of the data set.
    def median
      # TODO
    end

    # Generate a percentile for the data set.
    # @example
    #  snapshot.percentile(95)
    #  snapshot.percentile(99.9)
    #
    def percentile(perc)
      if perc > 100.0 || perc < 0.0
        raise InvalidPercentile, "percentile must be between 0.0 and 100.0"
      end


    end

  end

  class InvalidPercentile < StandardError; end
end
