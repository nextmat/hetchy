class Hetchy

  # Contains reservoir data frozen in time, created by Hetchy#snapshot.
  class Snapshot

    attr_reader :data

    def initialize(data)
      @data = data.sort
    end

  end

end
