# frozen_string_literal: true

module Cli
  class Runner
    def self.execute(input, output)
      cli = create_cli

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

    def self.create_cli
      db = Json::DbLoader.load('./json/map_reduce_response.json')
      echo = ARGV[0] == '--echo'

      Cli::Handler.new(db, echo:)
    end
  end
end
