# frozen_string_literal: true

require_relative 'boot'

db = Json::DbLoader.load('./json/map_reduce_response.json')
echo = ARGV[0] == '--echo'
cli = CliHandler.new(db, echo:)


until $stdin.eof?
  begin
    response = cli.take_one($stdin)
    puts response if response
  rescue CliHandler::Error => e
    warn(e.message)
  end
end
