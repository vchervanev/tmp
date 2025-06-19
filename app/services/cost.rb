# frozen_string_literal: true

class Cost < Array
  include Comparable

  def accumulate(addon)
    addon.each_with_index do |value, index|
      self[index] += value
    end
  end
end
