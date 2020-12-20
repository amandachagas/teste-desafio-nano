class Invoice < ApplicationRecord
  belongs_to :deputy

  validates :deputy, presence: true
end
