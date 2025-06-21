# frozen_string_literal: true

module CostFunction
  class Time
    attr_reader :db

    def initialize(db)
      @db = db
    end

    def call(sailings)
      days =
        if sailings.any?
          (sailings.last.arrival - sailings.first.departure).to_i
        else
          0
        end

      Cost.new([days])
    end
  end
end
