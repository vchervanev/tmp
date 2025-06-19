module SailingHelpers
  def next_date(reset: nil, step: 1)
    @date_sequence = Date.new(2022, 12, 31) if reset || @date_sequence.nil?

    @date_sequence += step
  end

  def sailing(origin, destination, departure, arrival)
    code = "#{origin}#{destination}"
    segment = Segment.new(origin, destination)
    rate = nil

    Sailing.new(code, segment, rate, departure, arrival)
  end
end