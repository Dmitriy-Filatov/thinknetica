hash_1 = {a: 1, e: 5, i: 9, o: 15, u: 21, y: 25, b: 2, c: 3, d: 4, f: 6, g: 7,
  h: 8, j: 10, k: 11, l: 12, m: 13, n: 14, p: 16, q: 17, r: 18, s: 19, t: 20,
  v: 22, w: 23, x: 24, z: 26
}
hash_2 = hash_1.select! { |k, v| [:a, :e, :i, :o, :u, :y].include?(k) }
p hash_1
