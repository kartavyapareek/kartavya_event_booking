# Event Booking System

A simple event booking system built using Ruby on Rails. The system allows users to create events, book tickets for events, and view events. ( Depends on the user role ) they've created or booked tickets for. The application handles user authentication, concurrency during ticket booking, and caching for performance optimization.

Please check seed file for the user login details 

## Features

- **User Registration & Authentication**: Users can register, log in, and log out using Devise.
- **Event Creation**: Authenticated users can create events with a name, description, location, date/time, and the total number of tickets available.
- **Ticket Booking**: Users can book tickets for events. They can book multiple tickets but cannot exceed the total available tickets.
- **View Events**: Users can view all events or the events they have created and the tickets they have booked.
- **Concurrency Handling**: The system handles concurrent ticket bookings to prevent overbooking.
- **Caching**: The list of events is cached for better performance and updated when a new event is created.


## Requirements

- Ruby 3.4.1
- Rails 8.0.1
- nodejs v23.6.0
- Bundler

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/kartavya/kartavya_event_booking.git

   cd kartavya_event_booking

2. Install the required gems::

    ```bash
   bundle install

3. Set up the database:

    ```bash
    rails db:create
    rails db:migrate
    rails db:seed

4. Start the Rails server:

    ```bash
    rails server

Your app will be available at http://localhost:3000.

## Scope of Improvements

The following improvements can be added in future versions:

- Edit and delete events, and manage event status (Live, Draft, Completed).
- Introduce ticket statuses (Draft, Payment Pending, Payment Done, Booked, Used).
- Add a feature to hold selected tickets during the booking process to prevent conflicts.
- Cooling period for ticket booking (hold tickets for 5 minutes while the user completes payment).