# frozen_string_literal: true

module ClusterId::Rails
  class Config
    attr_accessor :default_generator

    def add_generator(name, generator)
      raise NotAGeneratorError, "#{generator} is not a generator" unless GENERATOR_TYPES.include?(generator.class)

      @generators[name] = generator
    end

    def generator(name)
      @generators.fetch(name)
    end

    def initialize
      @generators = {}
      @default_generator = :default
    end

    private

    GENERATOR_TYPES = [
      ClusterId::V1::Generator
    ].freeze
  end
end
