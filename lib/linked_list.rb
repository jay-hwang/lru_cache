class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{val}"
  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.next = @tail
    @tail.prev = @head
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def [](idx)
    self.each_with_index { |link, j| return link if i == j }
    nil
  end

  def get(key)
    current_node = first
    until current_node == @tail
      return current_node.val if current_node.key == key
      current_node = current_node.next
    end
  end

  def include?(key)
    current_node = first
    until current_node == @tail
      return true if current_node.key == key
      current_node = current_node.next
    end
    false
  end

  def insert(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    new_link.next = @tail
    last.next = new_link
    @tail.prev = new_link
  end

  def empty?
    @head.next == @tail ? true : false
  end

  def remove(key)
    current_node = first
    until current_node == @tail
      if current_node.key == key
        current_node.next.prev = current_node.prev
        current_node.prev.next = current_node.next
      end
      current_node = current_node.next
    end
    nil
  end

  def each
    current_node = first
    until current_node == @tail
      yield current_node
      current_node = current_node.next
    end
  end

  def to_s
    self.inject([]) do |acc, link|
      acc << "[#{link.key}, #{link.val}]"
    end.join(', ')
  end
end



##########


list = LinkedList.new
list.insert(3,3)
list.insert(5,5)
list.insert(8,8)
list.insert(5,5)
list.insert(10,10)
list.insert(2,2)
list.insert(1,1)

def partition_duo(list, x)
  current_node = list.first
  until current_node == list.tail
    if current_node.val < x
      next_link = current_node.next
      current_node.prev.next = current_node.next
      current_node.next.prev = current_node.prev

      list.first.next.prev = current_node
      current_node.next = list.first.next
      current_node.prev = list.first
      list.first.next = current_node
      current_node = next_link
    else
      current_node = current_node.next
    end
  end
  list
end

list.each do |link|
  # byebug
  print "#{link.val} "
end

puts ''

part_list = partition_duo(list, 5)
part_list.each do |link|
  print "#{link.val} "
end
