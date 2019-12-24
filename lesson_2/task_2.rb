arr = (10..100).to_a
p arr.map.find_all { |elem| elem %  5 == 0 }
