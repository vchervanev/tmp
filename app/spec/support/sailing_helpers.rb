# frozen_string_literal: true

module SailingHelpers
  def next_date(reset: nil, step: 1)
    @date_sequence = Date.new(2022, 12, 31) if reset || @date_sequence.nil?

    @date_sequence += step
  end

  def sailing(origin, destination, departure, arrival)
    code = "#{origin}#{destination}"
    rate = nil

    Sailing.new(code, origin, destination, rate, departure, arrival)
  end
end
