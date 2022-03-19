# frozen_string_literal: true

module ClusterId
  module Rails
    DATA_TYPE = :clusterid
    DEFAULT_GENERATOR_NAME = :default
    BYTE_LENGTH = 16
    CROCKFORD32_LENGTH = 26

    class Error < StandardError; end

    class NotAGeneratorError < Error; end

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
