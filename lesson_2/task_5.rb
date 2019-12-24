print "Введите день:"
d = gets.chomp.to_i
print "Введите месяц:"
m = gets.chomp.to_i
print "Введите год:"
y = gets.chomp.to_i
arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
i = arr[m]
res = arr.take(m - 1).sum + d
if y % 4 == 0
  p res + 1
  elsif y % 100 == 0
  p res
  elsif y % 400 == 0
  p res + 1
  else
  p res
end
