# frozen_string_literal: true

RSpec.describe Json::SailingLoader do
  let(:payload) do
    JSON.parse(File.read('./spec/fixtures/map_reduce_minimal_response.json'), { object_class: OpenStruct })
  end
  let(:db) { Database.new }
  let(:rate) { instance_double('Rate', code: 'AB') }

  before do
    allow(db).to receive(:rate).with('AB').and_return(rate)
  end

  context '#parse' do
    it 'parses a valid payload' do
      described_class.parse(payload.sailings, db)
      sailing = db.sailing('AB')

      expect(sailing).to have_attributes(
        code: 'AB',
        segment: Segment.new('A', 'B'),
        rate: rate,
        departure: Date.parse('2000-01-01'),
        arrival: Date.parse('2000-01-10')
      )
    end
  end
end
