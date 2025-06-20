# frozen_string_literal: true

module CostFunction
  class Money
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def call(sailings)
      total = Cost.new([0])
      sailings&.each do |sailing|
        cost = calculate(sailing)
        total.accumulate(cost)
      end

      total
    end

    private

    def calculate(sailing)
      # we can use sailing duration as a tie breaker - confirm with product
      Cost.new([
                 convert(sailing.rate.amount, sailing.rate.currency, sailing.departure)
                 #  , sailing.days
               ])
    end

    def convert(amount, currency, date)
      return amount if currency == Currency.find!('EUR')

      rate = db.exchange(currency, date).rate
      # TODO: ask Finace team how to handle rounding
      amount * rate
    end
  end
end
