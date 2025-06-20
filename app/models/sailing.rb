# frozen_string_literal: true

Sailing = Struct.new(:code, :segment, :rate, :departure, :arrival) do
  def days
    (arrival - departure).to_i
  end

  def to_s
    "[#{segment.origin} -> #{segment.destination}: (#{departure} - #{arrival})]"
  end
end
