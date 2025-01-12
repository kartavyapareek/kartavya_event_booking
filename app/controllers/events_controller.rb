class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index ]
  before_action :check_organizer_role, only: [ :new, :create ]

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to events_path, notice: "Event created successfully!"
    else
      render :new
    end
  end

  def index
    @events = Event.all
  end

  private

  def event_params
    params.require(:event).permit(:name, :description, :location, :date_time, :total_tickets)
  end

  def check_organizer_role
    unless current_user.organizer?
      redirect_to root_path, alert: "You must be an organizer to create an event."
    end
  end
end
