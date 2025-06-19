Dir[File.join(__dir__, 'support', '**', '*.rb')].each { |f| require f }

RSpec.configure do |c|
  c.include SailingHelpers
  c.after do
    next_date(reset: true)
  end
end