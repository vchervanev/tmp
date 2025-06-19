# frozen_string_literal: true

RSpec.describe Sailing do
  let(:segment) { Segment.new('A', 'B') }
  let(:departure) { DateTime.parse('2023-01-01') }
  let(:arrival) { DateTime.parse('2023-01-04') }
  let(:sailing) { described_class.new('AB', segment, 10.2, departure, arrival) }

  context 'days' do
    it 'calculates the number of days between departure and arrival' do
      expect(sailing.days).to eq(3)
    end
  end
end
