[1,3,5,7].reduce(0) do |sum, element| 
  puts "sum: #{sum} -> element: #{element}"
  sum+element
end

[1,3,5,7].reduce(1) do |product, el| 
  puts"product:#{product} ->el: #{el}"
  product*el
end
