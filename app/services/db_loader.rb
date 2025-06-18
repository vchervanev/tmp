# frozen_string_literal: true

class DbLoader
  class << self
    def load(path)
      db = Database.new
      json = JSON.parse(File.read(path), { object_class: OpenStruct })

      ExchangeJsonLoader.parse(json.exchange_rates.to_h, db)
      RateJsonLoader.parse(json.rates, db)
      SailingJsonLoader.parse(json.sailings, db)

      db
    end
  end
end
