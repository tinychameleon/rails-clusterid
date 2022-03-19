# frozen_string_literal: true

require "clusterid"

module ClusterId::Rails
  class Type < ::ActiveRecord::Type::Binary
    def deserialize(value)
      return value.to_s if value.is_a?(::ActiveRecord::Type::Binary::Data)

      if database_adapter == :postgresql
        ::ActiveRecord::Base.connection.unescape_bytea(value)
      else
        value
      end
    end

    def serialize(value)
      return if value.nil?

      bytes = if value.length == CROCKFORD32_LENGTH
                Crockford32.decode(value, into: :string, length: BYTE_LENGTH)
              else
                value
              end

      ::ActiveRecord::Type::Binary::Data.new(bytes)
    end

    private

    def database_adapter
      ::ActiveRecord::Type.adapter_name_from(::ActiveRecord::Base)
    end
  end
end
