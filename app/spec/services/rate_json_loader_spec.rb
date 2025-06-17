# frozen_string_literal: true

RSpec.describe RateJsonLoader do
  let(:payload) do
    JSON.parse(File.read('./spec/fixtures/map_reduce_minimal_response.json'), { object_class: OpenStruct })
  end
  let(:sailing) { instance_double('Sailing', code: 'AB') }
  let(:db) { Database.new }

  context '#parse' do
    it 'parses a valid payload' do
      described_class.parse(payload.rates, db)
      rate = db.rate('AB')

      expect(rate).to have_attributes(
        code: 'AB',
        currency: Currency.find!('USD'),
        amount: BigDecimal('10.2')
      )
    end
  end
end
