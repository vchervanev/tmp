# frozen_string_literal: true

class Skipper
  class AppriserFactory
    def self.fastest_direct(db)
      Appriser.new(
        CostFunction::Money.new(db),
        max_legs: 1
      )
    end

    def self.fastest_indirect(db)
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

  attr_reader :db, :graph

  def initialize(db)
    @db = db
    @graph = Graph.from_sailings(db.storage[:sailings].values)
  end

  def route(origin, destination, strategy:)
    raise ArgumentError, 'Invalid strategy' unless AppriserFactory.respond_to?(strategy)

    appriser = AppriserFactory.send(strategy, db)
    PathFinder.new(
      origin, destination,
      graph: graph,
      appriser: appriser
    ).start

    appriser.best_journey
  end
end
