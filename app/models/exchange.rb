# frozen_string_literal: true

# ExchangeRate from EUR to :currency on :date
Exchange = Struct.new(:currency, :date, :rate)
