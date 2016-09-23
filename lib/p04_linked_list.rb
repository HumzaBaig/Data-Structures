class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new("head")
    @tail = Link.new("tail")
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next unless empty?
  end

  def last
    @tail.prev unless empty?
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    current_link = @head.next

    while current_link != @tail
      return current_link.val if current_link.key == key
      current_link = current_link.next
    end

    nil
  end

  def include?(key)
    current_link = @head.next

    while current_link != @tail
      return true if current_link.key == key
      current_link = current_link.next
    end

    false
  end

  def insert(key, val)
    if include?(key)
      get(key).val = val
    else
      link = Link.new(key, val)

      prev_last = @tail.prev

      link.prev = prev_last
      link.next = @tail

      prev_last.next = link
      @tail.prev = link
    end
  end

  def remove(key)
    return unless include?(key)

    trash_link = @head.next

    while trash_link != @tail
      break if trash_link.key == key
      trash_link = trash_link.next
    end

    prev_link = trash_link.prev
    next_link = trash_link.next

    prev_link.next = next_link
    next_link.prev = prev_link
  end

  def each(&prc)
    return if empty?

    current_link = first

    until current_link == @tail
      prc.call(current_link)
      current_link = current_link.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
