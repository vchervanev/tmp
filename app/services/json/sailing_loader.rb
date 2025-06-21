# frozen_string_literal: true

module Json
  class SailingLoader
    def self.parse(payload, db)
      raise ArgumentError, 'Payload must be an Array' unless payload.is_a?(Array)

      # Sample Payload Structure
      # [{
      #   "origin_port": "A",
      #   "destination_port": "B",
      #   "departure_date": "2000-01-01",
      #   "arrival_date": "2000-01-10",
      #   "sailing_code": "AB"
      # }, ...]
      payload.each do |rec|
        code = rec.sailing_code
        origin = rec.origin_port
        destination = rec.destination_port
        departure = Date.parse(rec.departure_date)
        arrival = Date.parse(rec.arrival_date)
        rate = db.rate(code)

        db.add_sailing(Sailing.new(code, origin, destination, rate, departure, arrival))
      end
    end
  end
end
