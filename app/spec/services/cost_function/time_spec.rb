# frozen_string_literal: true

RSpec.describe CostFunction::Time do
  let(:db) { Json::DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }

  it 'calculates the cost' do
    cost_function = described_class.new(db)
    sailing = db.sailing('AB')

    cost = cost_function.call([sailing])

    # 2000-01-01..2000-01-10 - 9 days
    expect(cost).to eq([9])
  end
end
