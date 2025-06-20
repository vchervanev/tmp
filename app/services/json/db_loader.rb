# frozen_string_literal: true

module Json
  class DbLoader
    class << self
      def load(path)
        db = Database.new
        json = JSON.parse(File.read(path), { object_class: OpenStruct })

        ExchangeLoader.parse(json.exchange_rates.to_h, db)
        RateLoader.parse(json.rates, db)
        SailingLoader.parse(json.sailings, db)

        db
      end
    end
  end
end
