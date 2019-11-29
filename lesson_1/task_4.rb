print "Введите а:"
a = gets.chomp.to_i
while a == 0
  puts "Значение не может быть равно 0"
  print "Введите а:"
  a = gets.chomp.to_i
end
print "Введите b:"
b = gets.chomp.to_i
print "Введите c:"
c = gets.chomp.to_i
_D = b**2 - 4*a*c
if _D > 0
  _C = Math.sqrt(_D)
   x1 = (-b + _C) / (2*a)
   x2 = (-b - _C) / (2*a)
   puts "Дискриминант = #{_D}"
   puts "Корень 1 = #{x1}"
   puts "Корень 2 = #{x2}"
elsif _D == 0
  x1 = -b / (2*a)
  puts "Дискриминант = 0"
  puts "Корень 1 = #{x1}"
else
  puts "Дискриминант = #{_D}. Корней нет!"
end
