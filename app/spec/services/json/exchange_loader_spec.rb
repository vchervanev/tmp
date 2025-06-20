# frozen_string_literal: true

RSpec.describe Json::ExchangeLoader do
  let(:payload) do
    JSON.parse(File.read('./spec/fixtures/map_reduce_minimal_response.json'), { object_class: OpenStruct })
  end
  let(:db) { Database.new }

  context '#parse' do
    it 'parses a valid payload' do
      described_class.parse(payload.exchange_rates.to_h, db)
      usd = Currency.find!('USD')
      date = Date.parse('2000-01-01')
      exchange = db.exchange(usd, date)

      expect(exchange).to have_attributes(
        date: Date.parse('2000-01-01'),
        rate: BigDecimal('1.5'),
        currency: Currency.find!('USD')
      )
    end
  end
end
