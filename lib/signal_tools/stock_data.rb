
module SignalTools
  class StockData
    # Extra days needed to produce accurate data for the desired date.
    Extra_Days = 365
    Indexes = {
      :date           => 0,
      :open           => 1,
      :low            => 2,
      :high           => 3,
      :close          => 4,
#Presently unused
#      :volume         => 5,
#      :adjusted_close => 6
    }
    attr_reader :raw_data, :dates

    ## NOTE: raw is an array of arrays format of indexes as defined by Indexes above
    def initialize(raw)
      raw.each_with_index do |row, idx|
        row[Indexes[:open]]  = row[Indexes[:open]].to_f   if row[Indexes[:open]].is_a? String
        row[Indexes[:high]]  = row[Indexes[:high]].to_f   if row[Indexes[:high]].is_a? String
        row[Indexes[:low]]   = row[Indexes[:low]].to_f    if row[Indexes[:low]].is_a? String
        row[Indexes[:close]] = row[Indexes[:close]].to_f  if row[Indexes[:close]].is_a? String
      end
      @raw_data = raw
      @start_date, @end_date = date_range()
      # We will never have need of the extraneous dates so we trim here
      @dates = trim_dates()
    end

    def open_prices
      @open_prices ||= @raw_data.map { |d| d[Indexes[:open]].to_f }
    end

    def high_prices
      @high_prices ||= @raw_data.map { |d| d[Indexes[:high]].to_f }
    end

    def low_prices
      @low_prices ||= @raw_data.map { |d| d[Indexes[:low]].to_f }
    end

    def close_prices
      @close_prices ||= @raw_data.map { |d| d[Indexes[:close]].to_f }
    end

    def date_range
      puts ">>>>>  made it into date_range"
      all_dates = @raw_data.map{|d| d[Indexes[:date]]}
      all_dates.each_with_index do |val, idx|
        begin
          all_dates[idx] = Date.parse(val)
        rescue => e
          all_dates[idx] = nil
        end
      end
      return all_dates.min, all_dates.max
    end

    private

    def trim_dates
      puts ">>>>>  made it into trim_dates"
      dates = @raw_data.map { |d| d[Indexes[:date]] }
      #index = binary_search_for_date_index(dates)
      #dates[(index+1)..-1]
    end

    # Performs a binary search for @from_date on @dates. Returns the index of @from_date.
    # def binary_search_for_date_index(dates, low=0, high=dates.size-1)
    #   puts ">>>>>  made it into binary_search_for_date_index. params: dates: #{dates} \tlow: #{low} \t high: #{high}"
    #   return low if high <= low    # closest match
    #   mid = low + (high - low) / 2
    #   if dates[mid] > @from_date
    #     binary_search_for_date_index(dates, low, mid-1)
    #   elsif dates[mid] < @from_date
    #     binary_search_for_date_index(dates, mid+1, high)
    #   else
    #     mid
    #   end
    # end
  end
end
