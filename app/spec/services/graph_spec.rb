# frozen_string_literal: true

RSpec.describe Graph do
  subject(:graph) { described_class.from_sailings(sailings) }
  let(:sailings) { [] }

  context 'single option A -> B -> C' do
    let(:sailings) do
      [
        sailing('A', 'B', next_date, next_date),
        sailing('B', 'C', next_date, next_date)
      ]
    end

    it 'registers and visits the edges' do
      result = []
      graph.sailings_from('A', after: nil) do |sailing|
        result << sailing
        graph.sailings_from(sailing.segment.destination, after: sailing.departure) do |next_sailing|
          result << next_sailing
        end
      end

      expect(result).to match(sailings)
    end
  end

  context 'multiple dates for the same route' do
    let(:days) { Array.new(4) { next_date } }
    let(:sailings) do
      [
        sailing('A', 'B', days[0], days[1]),
        sailing('A', 'B', days[2], days[3])
      ]
    end

    def fetch_after(after)
      result = []
      graph.sailings_from('A', after:) do |sailing|
        result << sailing
      end

      result
    end

    it 'fetches future sailings' do
      expect(fetch_after(nil)).to match(sailings)
    end

    it 'fetches one sailing after the middle date' do
      expect(fetch_after(days[0])).to match([sailings.last])
    end

    it 'fetches no sailings after the last departure date' do
      expect(fetch_after(days[2])).to be_empty
    end
  end
end
