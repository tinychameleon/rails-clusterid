# frozen_string_literal: true

require "active_record/connection_adapters/abstract/schema_definitions"
module ClusterId::Rails
  class Railtie < ::Rails::Railtie
    initializer "clusterid_railtie" do |app|
      puts "rails-clusterid: initializing..."

      # With configuration that creates generators...
      #   config.clusterid.generators = [Gen.new, Gen2.new]
      #  
      #  - initializer can...
      #    - create the clusterid config app that has assignment methods
      #  - config/initializer can...
      #    - assign generators to .generators=

      # set the version of clusterid used here if not set
      # Construct a default generator for ActiveRecord to use

      # register the ActiveRecord data type here
      # require_relative "postgresql"
      ::ActiveRecord::ConnectionAdapters::TableDefinition.send(:define_column_methods, :clusterid)
      ::ActiveRecord::Base.connection.native_database_types[:clusterid] = { name: "bytea" }
      ::ActiveRecord::Type.register(:clusterid, ClusterId::Rails::ClusterIdColumn, override: false)
    end

    config.to_prepare do
      puts "rails-clusterid: configuring..."
      Railtie.setup!
    end

    def self.setup!
      config.clusterid = true
    end

    # Notes:
    #   - Rails seemed to call the initializer above BEFORE the configuring.
    #   - "initializer" is what we want.
    #   - "configuration" seems to be for after initialization
    #     - Used to configure specific Rails attributes
  end
end
