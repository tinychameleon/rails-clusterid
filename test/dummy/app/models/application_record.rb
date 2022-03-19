class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include ClusterId::Rails::Model
end
