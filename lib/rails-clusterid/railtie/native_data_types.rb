# frozen_string_literal: true

module ClusterId::Rails
  module NativeDataTypes
    def self.register_database_types!(adapter)
      ::ActiveRecord::Base.connection.native_database_types[DATA_TYPE] = { name: database_adapter_to_type(adapter) }
    end

    def self.database_adapter_to_type(adapter)
      case adapter
      when "postgresql" then "bytea"
      when "mysql"
      when "sqlite"
      end
    end
  end
end
