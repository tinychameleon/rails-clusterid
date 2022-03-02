# frozen_string_literal: true

module ClusterId::Rails
  class Config
    def generators(version)
      # look up the generator via version???
    end

    def generators=(array)
      # freeze the generators array...
    end

    def initialize
      @generators = [].freeze
    end
  end
end
