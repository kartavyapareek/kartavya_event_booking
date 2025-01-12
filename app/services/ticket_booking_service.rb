class TicketBookingService < ApplicationService
  def initialize(user, event, quantity)
    @user = user
    @event = event
    @quantity = quantity
  end

  def call
    # Check if there are enough available tickets
    if @event.available_tickets >= @quantity
      create_ticket
      { status: :success, message: "#{@quantity} tickets successfully booked for event #{@event.name}" }
    else
      # Return a failure status and a message to be handled in the controller
      { status: :failure, message: "Not enough tickets available" }
    end
  end

  private

  def create_ticket
    Ticket.create!(user: @user, event: @event, quantity: @quantity)
  end
end
