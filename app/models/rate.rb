# frozen_string_literal: true

Rate = Struct.new(:sailing, :currency, :amount) do
  def code
    sailing.code
  end
end
