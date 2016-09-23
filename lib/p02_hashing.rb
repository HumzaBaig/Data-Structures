class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    xor_sum = 0.hash
    self.each_with_index do |el, i|
      xor_sum ^= (el.hash - i)
    end
    xor_sum.hash
  end
end

class String
  def hash
    xor_sum = 0
    self.chars.each_with_index do |letter, i|
      xor_sum += (letter.ord ^ i)
    end
    xor_sum.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  # def hash
  #   0
  # end
  def hash
    xor_sum = 0.hash
    self.each do |key, value|
      xor_sum ^= (value.hash - key.hash)
    end
    xor_sum.hash
  end
end
