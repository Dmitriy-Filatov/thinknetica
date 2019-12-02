print 'Как Вас зовут?'
name = gets.chomp.capitalize
print 'Какой Ваш рост (см)?'
height = gets.chomp.to_i
if height > 0
  puts "Ваш идеальный вес #{(height - 110)*1.15} кг, #{name}."
else
  puts 'Ваш вес уже оптимльный.'
end
