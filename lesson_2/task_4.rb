a = ('a'..'z').to_a
hash_a = a.each.with_index(1).to_h
p hash_a.select { |k, v| ['a', 'e', 'i', 'o', 'u', 'y'].include?(k) }
