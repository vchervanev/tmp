# frozen_string_literal: true

RSpec.describe Cli::Formatter do
  let(:db) { Json::DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }
  let(:sailing) { db.sailing('AB') }
  let(:sailings) { [sailing, sailing] }
  let(:expected_output) do
    <<~JSON.chomp
      [
        {
          "origin_port": "A",
          "destination_port": "B",
          "departure_date": "2000-01-01",
          "arrival_date": "2000-01-10",
          "sailing_code": "AB",
          "rate": "10.20",
          "rate_currency": "USD"
        },
        {
          "origin_port": "A",
          "destination_port": "B",
          "departure_date": "2000-01-01",
          "arrival_date": "2000-01-10",
          "sailing_code": "AB",
          "rate": "10.20",
          "rate_currency": "USD"
        }
      ]
    JSON
  end

  it 'formats sailng list as JSON' do
    expect(described_class.sailings(sailings)).to match(expected_output)
  end
end
