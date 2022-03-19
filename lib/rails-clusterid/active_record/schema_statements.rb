# frozen_string_literal: true

module ClusterId::Rails
  module SchemaStatements
    def create_join_table(table_1, table_2, column_options: {}, **options)
      if ::ClusterId::Rails.clusterid_primary_keys?
        column_options.reverse_merge!(type: ::ClusterId::Rails::DATA_TYPE, foreign_key: true)
      end

      super(table_1, table_2, column_options: column_options, **options)
    end
  end
end
