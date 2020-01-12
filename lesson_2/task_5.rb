print "Введите день:"
d = gets.chomp.to_i
print "Введите месяц:"
m = gets.chomp.to_i
print "Введите год:"
y = gets.chomp.to_i
arr = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
arr[1] = 29 if y % 400 == 0 || ( y % 4 == 0 && y % 100 != 0)
i = arr[m]
res = arr.take(m - 1).sum + d
p res
