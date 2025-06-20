# frozen_string_literal: true

class PathFinder
  attr_reader :origin, :destination
  attr_reader :graph, :appriser

  def initialize(origin, destination, graph:, appriser:)
    @origin = origin
    @destination = destination
    @graph = graph
    @appriser = appriser
    raise ArgumentError, 'Unsupported appriser' unless %i[record continue?].all? { |method| appriser.respond_to?(method)}
  end

  def start
    visit(origin, journey: Journey.new)
  end

  def evaluate(journey)
    start_port = journey.start_port
    end_port = journey.end_port
    return :abort if start_port != origin

    if end_port == destination
      appriser.record(journey.deep_dup)
      return :end
    end

    appriser.continue?(journey) ? :continue : :abort
  end

  def visit(port, journey:)
    graph.sailings_from(port, after: journey&.arrival) do |sailing|
      next if journey.visited?(sailing.segment.destination)

      journey << sailing
      visit(sailing.segment.destination, journey:) if evaluate(journey) == :continue

      journey.rollback
    end
  end
end
