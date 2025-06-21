# frozen_string_literal: true

class AppriserFactory
  def self.cheapest_direct(db)
    Appriser.new(
      CostFunction::Money.new(db),
      max_legs: 1
    )
  end

  def self.cheapest(db)
    Appriser.new(
      CostFunction::Money.new(db)
    )
  end

  def self.shortest(db)
    Appriser.new(
      CostFunction::Time.new(db)
    )
  end
end
