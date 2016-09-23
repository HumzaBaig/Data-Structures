require 'byebug'

class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    @max = max
  end

  def insert(num)
    return if is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    return unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    validate!(num)
    @store[num]
  end

  def validate!(num)
    raise "Out of bounds" if num < 0 || num > @max
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    # @num_buckets = num_buckets
  end

  def insert(num)
    return if include?(num)
    self[num] << num
  end

  def remove(num)
    return unless include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[(num % num_buckets)]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # debugger
    return if include?(num)
    resize! if @count >= num_buckets
    self[num] << num
    @count += 1
  end

  def remove(num)
    return unless include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[(num % num_buckets)]
  end

  def num_buckets
    @store.length
  end

  def resize!
    old = @store.flatten
    @store = Array.new(num_buckets*2) { Array.new }
    @count = 0 
    old.each { |el| insert(el) }
  end
end
