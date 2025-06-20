# frozen_string_literal: true

class Graph
  attr_reader :edges, :ready

  #  Represents a directed graph of sailings between ports, ordered by departure date
  # { "OriginPort" => { "DestinationPort" => [sailing_on_date1, sailing_on_date2] } }
  def initialize
    @edges = {}
    @ready = false
  end

  def self.from_sailings(sailings)
    new.tap do |graph|
      sailings.each do |sailing|
        graph.add_edge(sailing)
      end
      graph.warmup
    end
  end

  def add_edge(sailing)
    destinations = edges[sailing.segment.origin] ||= {}
    sailings = destinations[sailing.segment.destination] ||= []
    sailings << sailing
  end

  def warmup
    edges.each_value do |destinations|
      destinations.each_value do |sailings|
        sailings.sort_by!(&:departure)
      end
    end
    @ready = true
  end

  def sailings_from(port, after:)
    raise 'Graph is not ready, call warmup first' unless ready

    destinations = edges[port]
    return unless destinations

    destinations.each_value do |sailings|
      # TODO: add binary search for sailings
      sailings.each do |sailing|
        next if after && sailing.departure <= after

        yield sailing
      end
    end
  end
end
