hash = {}
loop do
print 'Введите название:'
name = gets.chomp.downcase.to_s
break if name == 'stop'
print 'Введите количество:'
quant = gets.chomp.to_f
print 'Введите цену:'
price = gets.chomp.to_i
hash[name] = {price => quant}
end
puts hash
