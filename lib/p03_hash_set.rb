require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    return if include?(key)
    resize! if @count >= num_buckets
    self[key] << key
    @count += 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    return unless include?(key)
    self[key].delete(key)
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[(key.hash % num_buckets)]
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
