class Hetchy

  # Contains reservoir data frozen in time, created by #snapshot.
  class Snapshot

    attr_reader :data

    def initialize(data)
      @data = data
    end

  end

end
