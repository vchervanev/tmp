# frozen_string_literal: true

module Json
  class ExchangeLoader
    def self.parse(payload, db)
      raise ArgumentError, 'Payload must be an Hash' unless payload.is_a?(Hash)

      # Sample Payload Structure
      # {
      #   "2000-01-01": {
      #     "<currency_id>": <rate>,
      #   }
      # }
      payload.each do |date_s, values|
        date = Date.parse(date_s.to_s)
        raise ArgumentError, 'Currency list must respond to to_h' unless values.respond_to?(:to_h)

        values.to_h.each do |currency_id, amount|
          currency = Currency.find!(currency_id.to_s.upcase)
          # ask MapReduce to send exchange rates as strings since JSON uses inexact floats
          exchange = Exchange.new(currency, date, BigDecimal(amount.to_s))
          db.add_exchange(exchange)
        end
      end
    end
  end
end
