# frozen_string_literal: true

Dir[File.join(__dir__, 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |c|
  c.include SailingHelpers
  c.after do
    next_date(reset: true)
  end
end
