print 'Введите название:'
name = gets.chomp.downcase.to_s
print 'Введите цену:'
price = gets.chomp.to_i
print 'Введите количество:'
quant = gets.chomp.to_f

hash = {name => {price => quant}}

while name != 'stop' do
print 'Введите количество:'
quant = gets.chomp.to_f
print 'Введите цену:'
price = gets.chomp.to_i
print 'Введите название:'
puts name = gets.chomp.downcase.to_s
end

hash
