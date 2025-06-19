# frozen_string_literal: true

RSpec.describe CostFunction::Money do
  let(:db) { DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }

  it 'calculates the cost' do
    cost_function = described_class.new(db)
    sailing = db.sailing('AB')

    cost = cost_function.call([sailing])

    # 10.2 * 1.5 = 15.3 EUR, 9 days
    expect(cost).to eq([BigDecimal('15.3'), 9])
  end
end
