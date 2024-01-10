def stock_picker(days)
  buy_index = nil
  sell_index = nil
  max_profit = -Float::INFINITY
  days.each_with_index do |buy_price, i|
    next if buy_index.nil? == false && days[i] > days[buy_index]

    (i + 1..days.length - 1).to_a.each do |j|
      sell_price = days[j]
      next unless (sell_price - buy_price) > max_profit

      buy_index = i
      sell_index = j
      max_profit = sell_price - buy_price
    end
  end
  [buy_index, sell_index]
end

days = [17, 3, 6, 9, 15, 8, 6, 1, 10]
p stock_picker(days)

days = [2, 1, 1, 1, 1, 1]
p stock_picker(days)

days = [2, 2, 2, 2, 2, 1]
p stock_picker(days)
