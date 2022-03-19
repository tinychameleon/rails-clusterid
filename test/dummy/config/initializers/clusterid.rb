# frozen_string_literal: true

Rails.application.config.clusterid do |c|
  c.add_generator(:default, ClusterId::V1::Generator.new)
  c.add_generator(:v1, ClusterId::V1::Generator.new)
end

Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :clusterid
end
