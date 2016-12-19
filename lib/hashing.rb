class Array
  def my_hash
    self.each_with_index.inject(0) do |i_hash, (el, i)|
      (el.hash + i.hash) ^ i_hash
    end
  end
end

class String
  def my_hash
    self.chars.map do |str|
      str.ord
    end.my_hash
  end
end

class Hash
  def my_hash
    self.to_a.sort.map do |pair|
      pair.my_hash
    end.my_hash
  end
end
