# frozen_string_literal: true

module ClusterId::Rails
  class Railtie < ::Rails::Railtie
    initializer "rails_clusterid.column_methods" do
      ::ActiveRecord::ConnectionAdapters::TableDefinition.send(:define_column_methods, DATA_TYPE)
    end

    initializer "rails_clusterid.native_data_types" do
      adapter = ::ActiveRecord::Type.adapter_name_from(::ActiveRecord::Base)
      ::ActiveRecord::Base.connection.native_database_types[DATA_TYPE] = native_type(adapter)
    end

    initializer "rails_clusterid.activerecord_type" do
      ::ActiveRecord::Type.register(DATA_TYPE, ::ClusterId::Rails::Type, override: false)
    end

    initializer "rails_clusterid.configuration" do
      ::Rails::Application::Configuration.include(ApplicationConfiguration)
    end

    private

    def native_type(adapter)
      case adapter
      when :postgresql then { name: "bytea" }
      when :mysql2 then { name: "binary", limit: BYTE_LENGTH }
      when :sqlite3 then { name: "blob" }
      end
    end
  end
end
