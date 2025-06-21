# frozen_string_literal: true

RSpec.describe CostFunction::Time do
  def date(mm, dd)
    Date.parse("2000-#{mm}-#{dd}")
  end
  it 'calculates the cost' do
    cost_function = described_class.new(instance_double('Database'))
    sailing1 = sailing('A', 'B', date(1, 1), date(1, 6))
    sailing2 = sailing('A', 'B', date(2, 1), date(2, 6))

    cost = cost_function.call([sailing1, sailing2])

    # assuming we exclude the days between the sailings
    # 01-01..01-06 + 02-01..02-06 - 10 days
    expect(cost).to eq([10])
  end
end
