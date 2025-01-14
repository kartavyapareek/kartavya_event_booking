class TicketBookingService < ApplicationService
  def initialize(user, event, quantity)
    @user = user
    @event = event
    @quantity = quantity
  end

  def call
    ActiveRecord::Base.transaction do
      @event.reload # reload to ensure the latesh version

      if @event.available_tickets >= @quantity
        @event.update!(available_tickets: @event.available_tickets - @quantity)

        create_ticket

        { status: :success, message: "#{@quantity} tickets successfully booked for event #{@event.name}" }
      else
        { status: :failure, message: "Not enough tickets available" }
      end
    end
  rescue ActiveRecord::StaleObjectError
    { status: :failure, message: "Sorry, the event has already been fully booked." }
  rescue => e
    { status: :failure, message: e.message }
  end

  private

  def create_ticket
    Ticket.create!(user: @user, event: @event, quantity: @quantity)
  end
end
