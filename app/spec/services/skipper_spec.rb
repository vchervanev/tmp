# frozen_string_literal: true

RSpec.describe Skipper do
  subject(:skipper) { described_class.new(db) }
  let(:db) { Json::DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }

  it 'finds the route' do
    journey = skipper.route('A', 'B', strategy: :fastest_direct)
    expect(journey).to have_attributes(
      start_port: 'A',
      end_port: 'B',
      valid?: true
    )
  end
end
