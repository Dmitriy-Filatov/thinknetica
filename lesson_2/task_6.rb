hash = {}
sum_final = 0
loop do
  print 'Введите название товара или stop'
  name = gets.chomp.downcase.to_s
  break if name == 'stop'
  print 'Введите цену:'
  price = gets.chomp.to_i
  print 'Введите количество:'
  quant = gets.chomp.to_f
  hash[name] = {price => quant}
  puts hash
  sum_local = price * quant
  puts "<<Сумма за этот товар #{sum_local}>>"
  sum_final += price * quant
  puts "<<Итоговая сумма за все покупки #{sum_final}"
end
