# frozen_string_literal: true

RSpec.describe PathFinder do
  subject(:start_path_finder) { path_finder.start }

  let(:path_finder) { PathFinder.new('A', 'C', graph: graph, appriser: appriser) }
  let(:appriser) { appriser_class.new }
  let(:graph) { Graph.new }
  let(:sailings) { [] }

  let(:appriser_class) do
    Class.new do
      def journeys
        @journeys ||= []
      end

      def record(journey)
        journeys << journey
      end

      def continue?(_journey)
        true
      end
    end
  end

  before do
    sailings.each do |sailing|
      graph.add_edge(sailing)
    end
    graph.warmup
  end

  context 'single option A -> B -> C' do
    let(:sailings) do
      [
        sailing('A', 'B', next_date, next_date),
        sailing('B', 'C', next_date, next_date)
      ]
    end

    it 'finds the path from A to C' do
      path_finder = PathFinder.new('A', 'C', graph: graph, appriser: appriser)
      path_finder.start

      expect(appriser.journeys).to contain_exactly(
        have_attributes(
          start_port: 'A',
          end_port: 'C',
          valid?: true
        )
      )
    end

    context 'continue = false' do
      let(:lazy_appriser_class) do
        Class.new(appriser_class) do
          def continue?(_journey)
            false
          end
        end
      end
      let(:appriser) { lazy_appriser_class.new }

      it 'does not find the path when continue? is false' do
        start_path_finder
        expect(appriser.journeys).to be_empty
      end
    end
  end
end
