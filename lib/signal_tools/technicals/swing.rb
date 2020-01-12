require_relative 'common.rb'

module SignalTools::Technicals
  class Swing
    include Common

    DEFAULT_SWING_DAYS = 3

    attr_reader :data, :swing_lows, :swing_highs

    def initialize(data)
      @data = data
      @swing_lows = []
      @swing_highs = []
      #@period = period
      #@type = type
    end

    def find_swings(swing_days=DEFAULT_SWING_DAYS)
      find_swing_highs(swing_days)
      find_swing_lows(swing_days)
      return @swing_lows, @swing_highs
    end

    def find_swing_highs(swing_days=DEFAULT_SWING_DAYS)
      @data.dates.slice(3..-2).each_with_index do |dt, idx|
        @swing_highs[idx+3] = @data.close_prices[idx+2] > @data.close_prices[idx+1] && @data.close_prices[idx+2] > @data.close_prices[idx] && @data.close_prices[idx+3] < @data.close_prices[idx+2]
      end
    end

    def find_swing_lows(swing_days=DEFAULT_SWING_DAYS)
      @data.dates.slice(2..-2).each_with_index do |dt, idx|
        @swing_lows[idx+3] = @data.close_prices[idx+2] < @data.close_prices[idx+1] && @data.close_prices[idx+2] < @data.close_prices[idx] && @data.close_prices[idx+3] > @data.close_prices[idx+2]
      end
    end

  end
end
