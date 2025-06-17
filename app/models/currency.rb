# frozen_string_literal: true

Currency = Struct.new(:code) do
  CODES = %w[EUR JPY USD].freeze

  def self.all
    @all ||= CODES.map { |code| [code, new(code)] }.to_h
  end

  def self.find!(code)
    all.fetch(code)
  end
end
