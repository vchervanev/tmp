# frozen_string_literal: true

class Database
  attr_reader :storage
  UniqIndexError = Class.new(StandardError)
  NotFoundError = Class.new(StandardError)

  def initialize
    @storage = {
      exchanges: [],
      rates: {},
      sailings: {},
    }
  end

  # def add_exchange(exchange)
  #   storage[:exchanges] << exchange
  # end

  # {
  #   "sailing_code": "ABCD",
  #   "rate": "589.30",
  #   "rate_currency": "USD"
  # },
  def add_rate(rate)
    raise UniqIndexError, "Rate with code #{rate.code} already exists" if storage[:rates].key?(rate.code)

    storage[:rates][rate.code] = rate
  end

  def rate(code)
    storage[:rates].fetch(code) do
      raise NotFoundError, "Sailing with code #{code} not found"
    end
  end

  def add_sailing(sailing)
    raise UniqIndexError, "Sailing with code #{sailing.code} already exists" if storage[:sailings].key?(sailing.code)

    storage[:sailings][sailing.code] = sailing
  end

  def sailing(code)
    storage[:sailings].fetch(code) do
      raise NotFoundError, "Sailing with code #{code} not found"
    end
  end
end
