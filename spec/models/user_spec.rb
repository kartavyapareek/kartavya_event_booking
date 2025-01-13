require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:events) }
    it { is_expected.to have_many(:tickets) }
    it { is_expected.to have_many(:booked_events).through(:tickets).source(:event) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'defines the correct roles' do
      expect(User.roles.keys).to match_array(%w[customer organizer])
    end
  end
end
