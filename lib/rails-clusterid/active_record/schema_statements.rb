# frozen_string_literal: true

module ClusterId::Rails
  # Contains method overrides for database migrations.
  module SchemaStatements
    # Overrides the default +create_join_table+ to provide support for ClusterId primary keys
    # as foreign keys within join tables.
    def create_join_table(table_1, table_2, column_options: {}, **options)
      if ::ClusterId::Rails.clusterid_primary_keys?
        column_options.reverse_merge!(type: ::ClusterId::Rails::DATA_TYPE, foreign_key: true)
      end

      super(table_1, table_2, column_options: column_options, **options)
    end
  end
end
