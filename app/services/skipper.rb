# frozen_string_literal: true

class Skipper
  attr_reader :db, :graph

  def initialize(db)
    @db = db
    @graph = Graph.from_sailings(db.storage[:sailings].values)
  end

  def route(origin, destination, strategy:)
    raise ArgumentError, "Invalid strategy [#{strategy}]" unless AppriserFactory.respond_to?(strategy)

    appriser = AppriserFactory.send(strategy, db)
    PathFinder.new(
      origin, destination,
      graph: graph,
      appriser: appriser
    ).start

    appriser.best_journey
  end
end
