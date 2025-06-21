# frozen_string_literal: true

module Cli
  class Runner
    def self.execute(input, output)
      db = Json::DbLoader.load('./json/map_reduce_response.json')
      echo = ARGV[0] == '--echo'
      cli = CliHandler.new(db, echo:)

      until input.eof?
        begin
          response = cli.take_one($stdin)
          output.puts(response) if response
        rescue CliHandler::Error => e
          warn(e.message)
        end
      end
    end
  end
end
