# frozen_string_literal: true

RSpec.describe Json::DbLoader do
  subject(:load) { described_class.load(path) }
  let(:path) { './spec/fixtures/map_reduce_minimal_response.json' }

  it 'is populated with the expected data' do
    allow(Json::ExchangeLoader).to receive(:parse).and_call_original
    allow(Json::RateLoader).to receive(:parse).and_call_original
    allow(Json::SailingLoader).to receive(:parse).and_call_original

    db = load

    expect(Json::ExchangeLoader).to have_received(:parse).once
    expect(Json::RateLoader).to have_received(:parse).once
    expect(Json::SailingLoader).to have_received(:parse).once

    expect(db.storage.transform_values(&:size)).to eq(
      exchanges: 2,
      rates: 1,
      sailings: 1
    )
    expect(db.storage&.dig(:exchanges, 'USD')&.size).to eq(1)
  end
end
