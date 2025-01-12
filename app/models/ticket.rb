class Ticket < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
