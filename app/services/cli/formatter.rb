# frozen_string_literal: true

module Cli
  class Formatter
    def self.sailing_to_hash(sailing)
      {
        origin_port: sailing.origin,
        destination_port: sailing.destination,
        departure_date: sailing.departure.strftime('%Y-%m-%d'),
        arrival_date: sailing.arrival.strftime('%Y-%m-%d'),
        sailing_code: sailing.code,
        rate: format('%.2f', sailing.rate.amount),
        rate_currency: sailing.rate.currency.code
      }
    end

    def self.sailing(sailing)
      JSON.pretty_generate(sailing_to_hash(sailing))
    end

    def self.sailings(sailings)
      JSON.pretty_generate(sailings.map(&method(:sailing_to_hash)))
    end
  end
end
