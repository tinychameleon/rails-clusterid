# frozen_string_literal: true

require "clusterid"

module ClusterId::Rails
  # The ActiveRecord-compatible type representing a ClusterId value optionally
  # encoded using the Crockford32 algorithm.
  class Type < ::ActiveRecord::Type::Binary
    # Deserializes byte string ClusterId values from database reads.
    #
    # @param value [String, nil] The value stored in the database, possibly escaped.
    # @return [String, nil] The unescaped ClusterId byte string.
    def deserialize(value)
      return value.to_s if value.is_a?(Data)

      if database_adapter == :postgresql
        ::ActiveRecord::Base.connection.unescape_bytea(value)
      else
        value
      end
    end

    # Serializes byte string ClusterId values for database writes.
    #
    # @param value [String, nil] A ClusterId value as a byte string or the Crockford32
    #   encoding of that byte string.
    # @return [Data, nil] The ClusterId byte string wrapped
    #   inside a serialization helper class.
    def serialize(value)
      return if value.nil?

      bytes = if value.length == CROCKFORD32_LENGTH
                Crockford32.decode(value, into: :string, length: BYTE_LENGTH)
              else
                value
              end

      Data.new(bytes)
    end

    # A helper class for serializing byte strings.
    class Data < ::ActiveRecord::Type::Binary::Data; end

    private

    # Obtains the symbol representing the configured database adapter from
    # +ActiveRecord::Base+.
    def database_adapter
      ::ActiveRecord::Type.adapter_name_from(::ActiveRecord::Base)
    end
  end
end
