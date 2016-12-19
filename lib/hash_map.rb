require_relative 'hashing'
require_relative 'linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def get(key)
    bucket = get_bucket(key)
    bucket.get(key)
  end

  def set(key, val)
    resize! if @count >= num_buckets
    bucket = get_bucket(key)
    bucket.remove(key)
    bucket.insert(key, val)
    @count += 1
  end

  alias_method :[], :get
  alias_method :[]=, :set

  def include?(key)
    bucket = get_bucket(key)
    bucket.include?(key)
  end

  def delete(key)
    bucket = get_bucket(key)
    bucket.remove(key)
    @count -= 1
  end

  def each
    # default each
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  private
    def get_bucket(key)
      @store[key.hash % num_buckets]
    end

    def num_buckets
      @store.length
    end

    def resize!
      old_store = @store.flatten
      @store = Array.new(num_buckets * 2) { LinkedList.new }
      @count = 0
      old_store.each do |bucket|
        bucket.each { |link| set(link.key, link.val) }
      end
    end
end
