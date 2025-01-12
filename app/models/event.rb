class Event < ApplicationRecord
  belongs_to :user
  has_many :tickets
  has_many :customers, through: :tickets, source: :user

  # Validations
  validates_presence_of :name, :description, :location, :date_time, :total_tickets
  validates :total_tickets, numericality: { only_integer: true, greater_than: 0 }

  # Check the number of available tickets
  def available_tickets
    total_tickets - tickets.sum(:quantity)
  end
end
