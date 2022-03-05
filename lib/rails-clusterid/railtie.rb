# frozen_string_literal: true

require_relative "railtie/application_configuration"
require_relative "railtie/activerecord_type"
require_relative "railtie/native_data_types"
require_relative "railtie/table_definition"

module ClusterId::Rails
  class Railtie < ::Rails::Railtie
    initializer "rails_clusterid.column_methods" do
      TableDefinition.register_column_methods!
    end

    initializer "rails_clusterid.native_data_types" do |app|
      # TODO: check for nil database config
      adapter = app.config_for(:database)[:adapter]
      NativeDataTypes.register_database_types! adapter
    end

    initializer "rails_clusterid.activerecord_type" do
      ActiveRecordType.register!
    end

    initializer "rails_clusterid.configuration" do
      ::Rails::Application::Configuration.include(ApplicationConfiguration)
    end
  end
end
