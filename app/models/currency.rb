# frozen_string_literal: true

class Currency
  attr_reader :code

  CODES = %w[EUR JPY USD].freeze

  def initialize(code)
    @code = code
  end

  def self.all
    @all ||= CODES.map { |code| [code, new(code)] }.to_h
  end

  def self.find!(code)
    all.fetch(code)
  end
end
