# frozen_string_literal: true

Sailing = Struct.new(:code, :segment, :rate, :departure, :arrival) do
  def days
    (arrival - departure).to_i
  end
end
