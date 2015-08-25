module Hetchy

  # Takes a fixed immutable dataset (array of values) and provides
  # various statistical measurements.
  #
  class Dataset

    attr_reader :data,
                :size

    def initialize(data)
      @data = data.sort
      @size = @data.length
    end

    # @return [Float/Integer] median of the data set.
    def median
      percentile(50.0)
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
      return 0.0 if data.empty?

      rank = (perc / 100.0) * (size + 1)

      return data[0]          if rank < 1
      return data[-1]         if rank > size
      return data[rank - 1]   if rank == Integer(rank)
      weighted_average_for(rank)
    end

    private

    # when rank lands between values, generated a weighted average
    # of adjacent values
    def weighted_average_for(rank)
      above = data[rank.to_i]
      below = data[rank.to_i - 1]
      fractional = rank - rank.floor
      below + ((above - below) * fractional)
    end

  end

  class InvalidPercentile < StandardError; end
end
