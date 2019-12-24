p 10.times.each_with_object([0,1]) { |num, obj| obj << obj[-2] + obj[-1] }
