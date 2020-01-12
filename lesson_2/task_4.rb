a = [nil] + ('a'..'z').to_a
hash_a = a.each_with_index.to_h
hash_v = hash_a.select! { |k, v| ['a', 'e', 'i', 'o', 'u', 'y'].include?(k) }
p hash_v
