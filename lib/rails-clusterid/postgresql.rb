# frozen_string_literal: true

require "active_record/connection_adapters/abstract/schema_definitions"

module ActiveRecord
  module ConnectionAdapters
    module ClusterIdColumnMethods
      extend ActiveSupport::Concern

      class_methods do
        def self.clusterid(*names, **options)
          raise ArgumentError, "Missing column name(s) for clusterid" if names.empty?
          names.each { |name| column(name, :clusterid, **options) }
        end
      end
    end

    class TableDefinition
      include ClusterIdColumnMethods
    end

    class Table
      include ClusterIdColumnMethods
    end

    module PostgreSQL
      class TableDefinition < ActiveRecord::ConnectionAdapters::TableDefinition
        include ClusterIdColumnMethods
      end

      class Table < ActiveRecord::ConnectionAdapters::Table
        include ClusterIdColumnMethods
      end
    end
  end
end
