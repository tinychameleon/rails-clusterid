# frozen_string_literal: true

require_relative "railtie/activerecord_type"
require_relative "railtie/native_data_types"
require_relative "railtie/table_definition"

module ClusterId::Rails
  class Railtie < ::Rails::Railtie
    initializer "rails_clusterid.column_methods" do
      TableDefinition.register_column_methods!
    end

    initializer "rails_clusterid.native_data_types" do |app|
      adapter = app.config_for(:database)[:adapter]
      NativeDataTypes.register_database_types! adapter
    end

    initializer "rails_clusterid.activerecord_type" do
      ActiveRecordType.register!
    end
  end
end
