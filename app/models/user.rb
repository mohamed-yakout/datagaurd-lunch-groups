class User < ApplicationRecord
  belongs_to :unit

  scope :available, -> { where(is_available: true) }
  scope :not_available, -> { where(is_available: false) }
end
