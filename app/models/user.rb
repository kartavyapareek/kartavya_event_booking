class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :events
  has_many :tickets
  has_many :booked_events, through: :tickets, source: :event

  # Roles
  enum :role, { customer: "customer", organizer: "organizer" }
end
