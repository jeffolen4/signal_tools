require_relative "signal_tools/stock_data.rb"
require_relative "signal_tools/stock.rb"
require_relative "signal_tools/technicals/average_directional_index.rb"
require_relative "signal_tools/technicals/average_true_range.rb"
require_relative "signal_tools/technicals/common.rb"
require_relative "signal_tools/technicals/ema.rb"
require_relative "signal_tools/technicals/swing.rb"
require_relative "signal_tools/technicals/fast_stochastic.rb"
require_relative "signal_tools/technicals/slow_stochastic.rb"
require_relative "signal_tools/technicals/macd.rb"

module SignalTools
  def self.sum(array)
    array.inject(0) {|accum, c| accum + c.to_f }
  end

  def self.average(array)
    return nil if !array || array.size == 0
    sum(array).to_f / array.size
  end

  # Truncates all arrays to the size of the shortest array by cutting off the front
  # of the longer arrays.
  def self.truncate_to_shortest!(*arrays)
    shortest_size = arrays.inject(arrays.first.size) { |size, array| array.size < size ? array.size : size }
    arrays.each { |array| array.slice!(0...(array.size - shortest_size)) }
  end
end
