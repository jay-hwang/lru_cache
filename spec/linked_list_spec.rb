require 'rspec'
require 'linked_list'

desribe LinkedList do
  let(:test_hash) do
    { first: 1, second: 2, third: 3 }
  end

  let(:list) do
    list = LinkedList.new
    test_hash.each do |key, val|
      list.insert(key, val)
    end
    list
  end

  describe '#get' do
    it 'gets by key' do
      expect(list.get(:first )).to eq 1
      expect(list.get(:second)).to eq 2
      expect(list.get(:third )).to eq 3
    end

    it 'returns nil for absent keys' do
      expect(list.get(:hello)).to be_nil
    end
  end

  describe '#remove' do
    it 'removes a link by key' do
      expect(list.get(:first)).to eq 1
      list.remove(:first)
      expect(list.get(:first)).to be_nil
    end
  end

  describe '#include?' do
    it 'returns true if key is present' do
      expect(list.include?(:first)).to be true
    end

    it 'returns false if key is not present' do
      expect(list.include?(:hello)).to be false
    end
  end

  describe '#each' do
    it 'iterates through list and yields each link' do
      list_values = test_hash.values
      yielded_list_value = []
      list.each do |link|
        yielded_list_values << link.val
      end
      expect(yielded_list_values).to eq(list_values)
    end
  end

end
