require 'rspec'
require 'hash_map'

describe HashMap do
  let(:hash) do
    hash = HashMap.new
    hash.set(:first, 1)
    hash.set(:second, 2)
    hash.set(:third, 3)
    hash
  end

  describe '#[]' do
    it 'gets by key' do
      expect(hash[:first ]).to eq 1
      expect(hash[:second]).to eq 2
      expect(hash[:third ]).to eq 3
    end

    it 'returns nil for absent keys' do
      expect(hash[:hello]).to be_nil
    end
  end

  describe '#[]=' do
    it 'sets a key value pair' do
      hash[:fourth] = 4
      expect(hash[:fourth]).to eq 4
    end

    it 'overwrites any existing value for the given key' do
      hash[:one] = 1
      hash[:one] = 'hello world'
      expect(hash[:one]).to eq('hello world')
    end

    it 'works with various data types' do
      hash['fourth'] = 4
      hash[[5]] = 5

      expect(hash["fourth"]).to eq 4
      expect(hash[[5]]).to eq 5
    end
  end

  describe '#include?' do
    it 'returns true if a key is present' do
      expect(hash.include?(:first)).to be true
    end

    it 'returns false if a key is not in the hash' do
      expect(hash.include?(:hello)).to be false
    end
  end

  describe '#delete' do
    it 'deletes by key' do
      expect(hash[:first]).to eq 1
      hash.delete(:first)
      expect(hash[:first]).to be_nil
    end
  end

  describe '#count' do
    it 'increments count on insert' do
      expect(hash.count).to eq 3
    end

    it 'decrements count on delete' do
      hash.delete(:first)
      expect(hash.count).to eq 2
    end
  end

  describe '#my_each' do
    it 'iterates through all items and yields each key-value pair' do
      idx = 0
      values = (1..3).to_a
      hash.my_each do |key, value|
        expect(value).to eq values[idx]
        idx += 1
      end
    end
  end

  describe '#resize!' do
    before do
      allow(hash).to receive(:resize!).and_call_original
    end

    it 'calls #resize! when hash is full' do
      expect(hash).to receive(:resize!).exactly(1).times
      7.times { |i| hash[i] = i + 1 }
    end

    it 'doubles store size' do
      old_store_count = hash.instance_variable_get(:@store).length
      hash.send(:resize!)
      new_store_count = hash.instance_variable_get(:@store).length

      expect(old_store_count * 2).to eq(new_store_count)
    end

    it 're-hashes existing values to fit new store' do
      elements = [:first, :second, :third].map do |key|
        [key, hash[key]]
      end

      hash.send(:resize!)

      elements.each do |key, value|
        expect(hash[key]).to eq(value)
      end
    end
  end
end
