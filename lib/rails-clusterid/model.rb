# frozen_string_literal: true

module ClusterId::Rails
  module Model
    extend ActiveSupport::Concern

    included do
      before_create :rails_clusterid_assign_id

      private

      def rails_clusterid_assign_id
        # TODO: Need to use generator config and allow for custom generator name
      end
    end
  end
end
