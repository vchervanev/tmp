# frozen_string_literal: true

class Appriser
  attr_reader :cost_function, :best_journey, :current_cost

  # TODO: discuss with product and extract into ApprisalOptions
  # among with other configurable options. Or embedd into CostFunction
  # not enough information to decide yet.
  attr_reader :max_legs

  def initialize(cost_function, max_legs: nil)
    @cost_function = cost_function
    @best_journey = nil
    @current_cost = nil
    @max_legs = max_legs
  end

  def record(journey)
    new_cost = cost(journey)
    return unless current_cost.nil? || new_cost < current_cost

    @current_cost = new_cost
    @best_journey = journey
  end

  def continue?(journey)
    return false if max_legs && journey.size >= max_legs
    return true if best_journey.nil?

    new_cost = cost(journey)
    return false if new_cost > current_cost

    true
  end

  private

  # TODO: PERF-001 eliminate repeated cost calculations
  def cost(journey)
    total = cost_function.call(nil)
    journey.sailings.each do |sailing|
      addon = cost_function.call(sailing)
      total.accumulate(addon)
    end

    total
  end
end
