require 'rails_helper'

RSpec.describe TicketBookingService do
  let(:user) { create(:user, email: 'ticket@example.com') }
  let(:event) { create(:event, available_tickets: 10) }
  let(:quantity) { 5 }

  subject { described_class.new(user, event, quantity) }

  describe '#call' do
    context 'when there are enough tickets available' do
      it 'books the tickets and updates the event' do
        result = subject.call

        expect(result[:status]).to eq(:success)
        expect(result[:message]).to eq("#{quantity} tickets successfully booked for event #{event.name}")
        expect(event.reload.available_tickets).to eq(5)
        expect(Ticket.where(user: user, event: event, quantity: quantity)).to exist
      end
    end

    context 'when there are not enough tickets available' do
      let(:quantity) { 15 }

      it 'returns a failure status with an appropriate message' do
        result = subject.call

        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to eq('Not enough tickets available')
        expect(event.reload.available_tickets).to eq(10)
      end
    end

    context 'when a StaleObjectError is raised' do
      before do
        allow(event).to receive(:update!).and_raise(ActiveRecord::StaleObjectError)
      end

      it 'returns a failure status with a stale object message' do
        result = subject.call

        expect(result[:status]).to eq(:failure)
        expect(result[:message]).to eq('Sorry, the event has already been fully booked.')
      end
    end
  end
end
