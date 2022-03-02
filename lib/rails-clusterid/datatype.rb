# frozen_string_literal: true

require "clusterid"

module ClusterId::Rails
  class ClusterIdColumn < ::ActiveModel::Type::Value
    def type # must be a unique symbol representing the type
      :clusterid
    end

    def binary? # marked as :nodoc: in rails... should I be doing this?
      true
    end

    def deserialize(value)
      # from the database
      # generator from byte string here
    end

    def cast(value)
      # from user input / forms
      # probably the crockford32 encoded value, so:
      #   -> decode + generator from byte string?
    end

    def serialize(value)
      # from ruby type to database type
      # probably a ClusterId::V1::Value, so:
      #   -> bytes attribute?
    end
  end
end
