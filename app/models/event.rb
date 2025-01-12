class Event < ApplicationRecord
  belongs_to :user

  # Validations
  validates_presence_of :name, :description, :location, :date_time, :total_tickets
  validates :total_tickets, numericality: { only_integer: true, greater_than: 0 }
end
