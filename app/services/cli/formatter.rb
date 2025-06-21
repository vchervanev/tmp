# frozen_string_literal: true

module Cli
  class Formatter
    def self.sailing(sailing)
      JSON.pretty_generate(
        {
          origin_port: sailing.segment.origin,
          destination_port: sailing.segment.destination,
          departure_date: sailing.departure.strftime('%Y-%m-%d'),
          arrival_date: sailing.arrival.strftime('%Y-%m-%d'),
          sailing_code: sailing.code,
          rate: format('%.2f', sailing.rate.amount),
          rate_currency: sailing.rate.currency.code
        }
      )
    end

    def self.sailings(sailings)
      sailings.map(&method(:sailing)).join(",\n")
    end
  end
end
