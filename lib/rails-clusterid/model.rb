# frozen_string_literal: true

require "crockford32"

module ClusterId::Rails
  # An +ActiveSupport::Concern+ allowing automatic ClusterId primary keys for ActiveRecord models.
  module Model
    extend ActiveSupport::Concern

    included do
      attribute :id, DATA_TYPE

      before_create :assign_clusterid_to_id

      def friendly_id
        Crockford32.encode(id, length: CROCKFORD32_LENGTH)
      end

      def to_param
        friendly_id
      end

      private

      def clusterid_generator
        ::ClusterId::Rails::DEFAULT_GENERATOR_NAME
      end

      def assign_clusterid_to_id
        g = Rails.application.config.clusterid.generator(clusterid_generator)
        self.id = g.generate.bytes.reverse
      end
    end
  end
end
