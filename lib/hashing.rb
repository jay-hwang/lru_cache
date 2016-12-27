class Array
  def my_hash
    self.each.with_index.reduce(0) do |i_hash, (el, i)|
      (el.hash + i.hash) ^ i_hash
    end
  end
end

class String
  def my_hash
    self.chars.map { |str| str.ord }.my_hash
  end
end

class Hash
  def my_hash
    self.to_a.sort.map { |pair| pair.my_hash }.my_hash
  end
end
