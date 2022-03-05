# frozen_string_literal: true

module ClusterId::Rails
  module ActiveRecordType
    def self.register!
      ::ActiveRecord::Type.register(DATA_TYPE, ClusterId::Rails::ClusterIdColumn, override: false)
    end
  end
end
