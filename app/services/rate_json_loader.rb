# frozen_string_literal: true

class RateJsonLoader
  def self.parse(payload, db)
    raise ArgumentError, 'Payload must be an Array' unless payload.is_a?(Array)

    # Sample Payload Structure
    # [{
    #   "sailing_code": "ABCD",
    #   "rate": "589.30",
    #   "rate_currency": "USD"
    # }, ...]
    payload.each do |rec|
      code = rec.sailing_code
      currency = Currency.find!(rec.rate_currency)
      amount = BigDecimal(rec.rate)

      db.add_rate(Rate.new(code, currency, amount))
    end
  end
end
