class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :check_organizer_role, only: [ :new, :create, :show ]
  before_action :set_event, only: [ :show, :book_ticket ]
  after_action :expire_cache, only: [ :create ]

  def index
    @events = Rails.cache.fetch("all_events", expires_in: 12.hours) { Event.all }
  end


  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.available_tickets = @event.total_tickets

    if @event.save
      redirect_to events_path, notice: "Event created successfully!"
    else
      render :new
    end
  end

  def show
    # Fetch the tickets for the event
    @tickets = @event.tickets
  end

  def book_ticket
    quantity = params[:quantity].to_i

    result = TicketBookingService.call(current_user, @event, quantity) # Call the service

    if result[:status] == :success
      redirect_to booked_tickets_events_path, notice: result[:message]
    else
      redirect_to event_path(@event), alert: result[:message]
    end
  end

  def booked_tickets
    @booked_tickets = current_user.tickets
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :description, :location, :date_time, :total_tickets)
  end

  def check_organizer_role
    unless current_user.organizer?
      redirect_to root_path, alert: "You must be an organizer to create an event."
    end
  end

  def expire_cache
    Rails.cache.delete("all_events")
  end
end
