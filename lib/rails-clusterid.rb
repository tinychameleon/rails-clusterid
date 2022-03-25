# frozen_string_literal: true

# An extension to the ClusterId[https://rubygems.org/gems/clusterid] gem which integrates
# it into Ruby on Rails.
#
# @since 0.1.0
module ClusterId
  # The extension module which contains all Ruby on Rails integrations.
  module Rails
    # The data type symbol for use with ActiveRecord and Migrations.
    DATA_TYPE = :clusterid

    # The symbol representing the default ClusterId generator to use.
    DEFAULT_GENERATOR_NAME = :default

    # The byte length of a ClusterI value.
    BYTE_LENGTH = 16

    # The rune length of a ClusterId value when encoded with the Crockford32 algorithm.
    CROCKFORD32_LENGTH = 26

    # The base error type for {ClusterId::Rails}.
    class Error < StandardError; end

    # An error representing an invalid generator object is present in configuration.
    class NotAGeneratorError < Error; end

    # Checks whether ClusterId values are configured as the ActiveRecord primary key type.
    def self.clusterid_primary_keys?
      DATA_TYPE == ::Rails.application.config.generators.options.dig(:active_record, :primary_key_type)
    end
  end
end

require "clusterid"
require "crockford32"

require_relative "rails-clusterid/version"
require_relative "rails-clusterid/config"
require_relative "rails-clusterid/application_config"
require_relative "rails-clusterid/type"
require_relative "rails-clusterid/model"
require_relative "rails-clusterid/active_record/schema_statements"
require_relative "rails-clusterid/railtie"
