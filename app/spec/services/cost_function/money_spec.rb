# frozen_string_literal: true

RSpec.describe CostFunction::Money do
  let(:db) { Json::DbLoader.load('./spec/fixtures/map_reduce_minimal_response.json') }

  it 'calculates the cost' do
    cost_function = described_class.new(db)
    sailing = db.sailing('AB')

    cost = cost_function.call([sailing])

    # 10.2 * 1.5 = 15.3 EUR
    expect(cost).to eq([BigDecimal('15.3')])
  end

  it 'returns empty cost for empty journey' do
    db = described_class.new(instance_double('Database'))
    cost_function = described_class.new(db)

    expect(cost_function.call([])).to eq([0])
  end
end
