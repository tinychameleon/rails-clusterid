class User < ApplicationRecord
  has_many :settings, dependent: :destroy
  has_and_belongs_to_many :projects
end
