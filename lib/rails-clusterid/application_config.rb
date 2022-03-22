# frozen_string_literal: true

module ClusterId::Rails
  # An +ActiveSupport::Concern+ which provides a method to access a {Config} object
  # through +Rails::Configuration+.
  module ApplicationConfiguration
    extend ActiveSupport::Concern

    included do
      def clusterid
        @rails_clusterid_config ||= ::ClusterId::Rails::Config.new
        yield @rails_clusterid_config if block_given?
        @rails_clusterid_config
      end
    end
  end
end
