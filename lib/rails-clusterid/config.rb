# frozen_string_literal: true

module ClusterId::Rails
  # The configuration object added to the Rails configuration registry.
  class Config
    # Add a generator with a name to use within models.
    #
    # @param name [Symbol] The name to associate with the provided generator.
    # @param generator [ClusterId::V1::Generator] A generator to use with models.
    #
    # @raise [NotAGeneratorError] when +generator+ is not one of the allowed {GENERATOR_TYPES}.
    # @return [ClusterId::V1::Generator] The added generator.
    def add_generator(name, generator)
      raise NotAGeneratorError, "#{generator} is not a generator" unless GENERATOR_TYPES.include?(generator.class)

      @generators[name] = generator
    end

    # Get a generator by registered name.
    #
    # @param name [Symbol] The registered name of a generator.
    #
    # @raise [KeyError] when the given +name+ was not registered via {add_generator}.
    # @return [ClusterId::V1::Generator] The registered generator with the given name.
    def generator(name)
      @generators.fetch(name)
    end

    def initialize
      @generators = {}
    end

    private

    # Allowed ClusterId generator types.
    GENERATOR_TYPES = [
      ClusterId::V1::Generator
    ].freeze
  end
end
