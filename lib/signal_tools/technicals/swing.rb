require_relative 'common.rb'

module SignalTools::Technicals
  class Swing
    include Common

    DEFAULT_SWING_DAYS = 3

    attr_reader :stock_data

    def initialize(stock_data)
      @data = stock_data
      @swing_lows = []
      @swing_highs = []
      #@period = period
      #@type = type
    end

    def find_swings(swing_days=DEFAULT_SWING_DAYS)
      @swing_highs = find_swing_highs(swing_days)
      @swing_lows = find_swing_lows(swing_days)
      return @swing_lows, @swing_highs
    end

    def find_swing_highs(swing_days=DEFAULT_SWING_DAYS)
      @data.dates.slice(3..-2).each_with_index do |dt, idx|
        @swing_highs[idx+3] = @data.close_prices[idx+2] > @data.close_prices[idx+1] && @data.close_prices[idx+2] > @data.close_prices[idx] && @data.close_prices[idx+3] < @data.close_prices[idx+2]
        #puts "Swing High Date: #{dt}\tindex: #{idx}" if @swing_highs[idx+3] == true
        #puts "\n\t#{@data.dates[idx]}: #{@data.close_prices[idx]} \n\t#{@data.dates[idx+1]}: #{@data.close_prices[idx+1]} \n\t#{@data.dates[idx+2]}: #{@data.close_prices[idx+2]} \n\t#{@data.dates[idx+3]}: #{@data.close_prices[idx+3]}" if @swing_highs[idx+3] == true
      end
    end

    def find_swing_lows(swing_days=DEFAULT_SWING_DAYS)
      @data.dates.slice(2..-2).each_with_index do |dt, idx|
        @swing_lows[idx+3] = @data.close_prices[idx+2] < @data.close_prices[idx+1] && @data.close_prices[idx+2] < @data.close_prices[idx] && @data.close_prices[idx+3] > @data.close_prices[idx+2]
        #puts "Swing Low Date: #{dt}\tindex: #{idx}" if @swing_lows[idx+3] == true
        #puts "\n\t#{@data.dates[idx]}: #{@data.close_prices[idx]} \n\t#{@data.dates[idx+1]}: #{@data.close_prices[idx+1]} \n\t#{@data.dates[idx+2]}: #{@data.close_prices[idx+2]} \n\t#{@data.dates[idx+3]}: #{@data.close_prices[idx+3]}" if @swing_lows[idx+3] == true
      end
    end

  end
end
