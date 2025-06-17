# frozen_string_literal: true

RSpec.describe 'E2E Test' do
  it 'reads from stdin and outputs to stdout' do
    output = IO.popen('cat spec/fixtures/input.txt | ruby main.rb', 'r', &:read)
    expect(output).to_not be_empty
  end
end
