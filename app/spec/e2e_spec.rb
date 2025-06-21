# frozen_string_literal: true

RSpec.describe 'E2E Test' do
  it 'reads from stdin and outputs to stdout' do
    output = IO.popen('cat spec/fixtures/input.txt | ruby main.rb --echo', 'r', &:read)
    expect(output).to eq(File.read('spec/fixtures/output.txt'))
  end

  it 'handles invalid input gracefully' do
    # mixing stdin and stderr
    output = IO.popen('cat spec/fixtures/invalid_input.txt | ruby main.rb 2>&1', 'r', &:read)
    expect(output).to eq(File.read('spec/fixtures/err_output.txt'))
  end
end
