# frozen_string_literal: true

RSpec.describe DbLoader do
  subject(:load) { described_class.load(path) }
  let(:path) { './spec/fixtures/map_reduce_minimal_response.json' }

  it 'is populated with the expected data' do
    allow(ExchangeJsonLoader).to receive(:parse).and_call_original
    allow(RateJsonLoader).to receive(:parse).and_call_original
    allow(SailingJsonLoader).to receive(:parse).and_call_original

    db = load

    expect(ExchangeJsonLoader).to have_received(:parse).once
    expect(RateJsonLoader).to have_received(:parse).once
    expect(SailingJsonLoader).to have_received(:parse).once

    expect(db.storage.transform_values(&:size)).to eq(
      exchanges: 2,
      rates: 1,
      sailings: 1
    )
    expect(db.storage&.dig(:exchanges, 'USD')&.size).to eq(1)
  end
end
