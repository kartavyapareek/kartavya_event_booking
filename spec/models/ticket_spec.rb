require 'rails_helper'

RSpec.describe Ticket, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:event) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:quantity) }

    it {
      is_expected.to validate_numericality_of(:quantity)
        .only_integer
        .is_greater_than(0)
    }
  end
end
