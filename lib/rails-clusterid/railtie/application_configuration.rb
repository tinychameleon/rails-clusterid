# frozen_string_literal: true

module ClusterId::Rails
  module ApplicationConfiguration
    extend ActiveSupport::Concern

    included do
      def clusterid
        @rails_clusterid_config ||= ClusterId::Rails::Config.new
        yield @rails_clusterid_config
      end
    end
  end
end
