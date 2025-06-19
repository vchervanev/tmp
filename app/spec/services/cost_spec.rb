# frozen_string_literal: true

RSpec.describe Cost do
  context '#accumulate' do
    it 'adds up cost vectors' do
      initial = Cost.new([1, 2, 3])
      addon = Cost.new([4, 5, 6])

      expect { initial.accumulate(addon) }
        .to change { initial }
        .from([1, 2, 3])
        .to([5, 7, 9])
    end
  end

  context 'comparable' do
    it 'compares cost vectors' do
      cost1 = Cost.new([1, 2, 3])
      cost2 = Cost.new([2, 2, 3])
      cost3 = Cost.new([1, 2, 5])

      expect(cost1 < cost2).to be true
      expect(cost1 > cost2).to be false
      expect(cost1 < cost3).to be true
    end
  end
end
