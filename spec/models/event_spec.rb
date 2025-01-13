require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:tickets) }
    it { should have_many(:customers).through(:tickets).source(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:date_time) }
    it { should validate_presence_of(:total_tickets) }

    it {
      should validate_numericality_of(:total_tickets)
        .only_integer
        .is_greater_than(0)
    }
  end

  describe '#booked_tickets' do
    it 'calculates the number of booked tickets correctly' do
      user = User.create!(email: 'test@example.com', password: 'password')
      event = Event.create!(
        name: 'Concert',
        description: 'Live music event',
        location: 'Stadium',
        date_time: Time.now + 1.day,
        total_tickets: 100,
        user: user
      )
      allow(event).to receive(:available_tickets).and_return(40)

      expect(event.booked_tickets).to eq(60)
    end
  end
end
