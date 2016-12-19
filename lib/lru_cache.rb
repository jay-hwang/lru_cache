require_relative 'hash_map'
require_relative 'linked_list'

class LRUCache
  attr_reader :count

  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    link = @map[key]
    if link
      update_link!(link)
    else
      calc!(key)
    end
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

    def calc!(key)
      val = @prc.call(key)
      new_link = @store.insert(key, val)
      @map[key] = new_link
      eject! if count > @max
      val
    end

    def update_link!(link)
      link.next.prev = link.prev
      link.prev.next = link.next

      link.next = @store.last.next
      link.prev = @store.last

      @store.last.next = link
      @store.last.next.prev = link
    end

    def eject!
      delete_link = @store.first
      @store.first.prev.next = delete_link.next
      delete_link.next.prev = delete_link.prev
      @map.delete(delete_link.key)
    end
end
