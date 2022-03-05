# frozen_string_literal: true

module ClusterId::Rails
  module TableDefinition
    def self.register_column_methods!
      ::ActiveRecord::ConnectionAdapters::TableDefinition.send(:define_column_methods, DATA_TYPE)
    end
  end
end
