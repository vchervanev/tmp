# frozen_string_literal: true

Journey = Struct.new(:sailings, :ports) do
  def initialize
    super([], Set.new)
  end

  def <<(sailing)
    raise ArgumentError, 'Invalid journey' if arrival && sailing.departure <= arrival

    sailings << sailing
    ports << sailing.segment.origin
    ports << sailing.segment.destination
  end

  def rollback
    ports.delete(sailings.last.segment.destination)
    sailings.pop
  end

  def visited?(port)
    ports.include?(port)
  end

  def start_port
    sailings.first&.segment&.origin
  end

  def end_port
    sailings.last&.segment&.destination
  end

  def departure
    sailings.first&.departure
  end

  def arrival
    sailings.last&.arrival
  end

  def deep_dup
    self.class.new.tap do |instance|
      %i[sailings ports].each do |attr|
        instance[attr] = send(attr).dup
      end
    end
  end

  def valid?
    return false if sailings.empty?

    sailings.each_cons(2) do |sailing1, sailing2|
      return false if sailing1.segment.destination != sailing2.segment.origin
      return false if sailing1.arrival >= sailing2.departure
    end

    true
  end

  def to_s
    sailings.map(&:to_s).join(' -> ')
  end
end
