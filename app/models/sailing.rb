# frozen_string_literal: true

Sailing = Struct.new(:code, :origin, :destination, :rate, :departure, :arrival) do
  def days
    (arrival - departure).to_i
  end

  def to_s
    "[{#{code}}:#{origin}->#{destination}: (#{departure}-#{arrival})]"
  end
end
