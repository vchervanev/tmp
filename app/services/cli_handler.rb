# frozen_string_literal: true

class CliHandler
  attr_reader :db, :skipper, :state, :values, :echo

  Error = Class.new(StandardError)

  ORIGIN = 0
  DESTINATION = 1
  STRATEGY = 2

  def initialize(db, echo: false)
    @db = db
    @skipper = Skipper.new(db)
    @echo = echo
  end

  def take_one(io)
    values = Array.new(3).map { io.readline.chomp }
    output = execute(
      values[ORIGIN],
      values[DESTINATION],
      values[STRATEGY].gsub('-', '_').to_sym
    )

    output = "#{values.join("\n")}\n#{output}" if echo

    output
  end

  def execute(origin, destination, strategy)
    journey = skipper.route(origin, destination, strategy:)
    if journey
      journey.sailings
      Cli::Formatter.sailings(journey.sailings)
    else
      "No route found\n"
    end
    # rescue StandardError => e
    # raise Error, e.message
  end
end
