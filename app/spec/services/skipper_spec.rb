# frozen_string_literal: true

RSpec.describe Skipper do
  subject(:skipper) { described_class.new(db) }
  let(:db) { Json::DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }

  it 'finds the route' do
    journey = skipper.route('A', 'B', strategy: :cheapest_direct)
    expect(journey).to have_attributes(
      start_port: 'A',
      end_port: 'B',
      valid?: true
    )
  end

  context 'e2e routing tests' do
    let(:db) { Json::DbLoader.load('spec/fixtures/map_reduce_e2e_response.json') }

    it 'picks the less expensive direct route' do
      journey = skipper.route('A', 'B', strategy: :cheapest_direct)
      expect(journey.sailings).to contain_exactly(
        have_attributes(
          code: 'less-expensive-direct'
        )
      )
    end

    it 'prefers cheaper 2-leg route when allowed' do
      journey = skipper.route('A', 'B', strategy: :cheapest)
      expect(journey.sailings).to contain_exactly(
        have_attributes(
          code: 'cheap-indirect-leg1'
        ),
        have_attributes(
          code: 'cheap-indirect-leg2'
        )
      )
    end

    it 'picks the shorter but more expensive direct route as fastest' do
      journey = skipper.route('A', 'B', strategy: :fastest)
      expect(journey.sailings).to contain_exactly(
        have_attributes(
          code: 'expensive-faster-direct'
        )
      )
    end
  end
end
