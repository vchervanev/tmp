# frozen_string_literal: true

module Cli
  class Runner
    def self.execute(input, output)
      db = Json::DbLoader.load('./json/map_reduce_response.json')
      echo = ARGV[0] == '--echo'
      cli = Cli::Handler.new(db, echo:)

      until input.eof?
        begin
          response = cli.take_one($stdin)
          output.puts(response) if response
        rescue Cli::Handler::Error => e
          warn(e.message)
        rescue Interrupt
          warn("\nExiting...")
          exit
        end
      end
    end
  end
end
