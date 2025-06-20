# frozen_string_literal: true

RSpec.describe Appriser do
  let(:cost_function) { ->(sailing) { Cost.new([sailing&.code.to_i]) } }

  def journey_with_cost(cost)
    sailing = instance_double('Sailing', code: cost.to_s)
    instance_double('Journey', sailings: [sailing])
  end

  subject(:appriser) { described_class.new(cost_function) }

  context '#record' do
    it 'keeps the best journey with the lowest cost' do
      j10 = journey_with_cost(10)
      appriser.record(j10)
      expect(appriser.current_cost).to eq([10])
      expect(appriser.best_journey).to eq(j10)

      appriser.record(journey_with_cost(15))
      expect(appriser.current_cost).to eq([10])
      expect(appriser.best_journey).to eq(j10)

      j1 = journey_with_cost(1)
      appriser.record(j1)
      expect(appriser.current_cost).to eq([1])
      expect(appriser.best_journey).to eq(j1)
    end
  end

  context '#continue?' do
    it 'returns true when no best journey' do
      j1 = instance_double('Journey', size: 1)

      expect(appriser.continue?(j1)).to eq(true)
    end

    context 'when best journey is set' do
      let(:best_journey) { journey_with_cost(10) }

      before do
        appriser.record(best_journey)
      end

      it 'returns false when new cost is higher' do
        j20 = journey_with_cost(20)
        expect(appriser.continue?(j20)).to eq(false)
      end

      it 'returns true while new cost is lower' do
        j5 = journey_with_cost(5)
        expect(appriser.continue?(j5)).to eq(true)
      end
    end

    context 'max_legs is set' do
      let(:appriser) { described_class.new(cost_function, max_legs: 2) }

      it 'returns false when journey size reaches it' do
        j2 = instance_double('Journey', size: 2)

        expect(appriser.continue?(j2)).to eq(false)
      end

      it 'returns true when size < max_legs t' do
        j1 = instance_double('Journey', size: 1)

        expect(appriser.continue?(j1)).to eq(true)
      end
    end
  end
end
