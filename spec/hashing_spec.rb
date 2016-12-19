require 'rspec'
require 'hashing'

describe "Hashing" do
  describe Array do
    it 'hashes to an integer' do
      expect([1,2].my_hash).to be_a(Integer)
    end

    it 'hashes deterministically' do
      a = [1, 2, 3]
      expect(a.my_hash).to eq(a.my_hash)
    end

    it 'produces same hash for two eq arrays' do
      a = [1, 2, 3]
      b = [1, 2, 3]
      expect(a.my_hash).to eq(b.my_hash)
    end

    it 'produces different hash for different orderings of array' do
      a = (1..50).to_a
      expect(a.my_hash).not_to eq(a.shuffle.my_hash)
    end

    it 'produces different hash for sub-arrays' do
      a = [1, 2]
      b = [1, 2, 3]
      expect(a.my_hash).not_to eq(b.my_hash)
    end

    it 'handles empty arrays' do
      expect([].my_hash).to be_a(Integer)
    end
  end

  describe String do
    it 'hashes to an integer' do
      expect("Ruby".my_hash).to be_a(Integer)
    end

    it 'hashes deterministically' do
      a = 'string'
      expect(a.my_hash).to eq(a.my_hash)
    end

    it 'produces same hash for two eq strings' do
      a = 'string'
      b = 'string'
      expect(a.my_hash).to eq(b.my_hash)
    end

    it 'produces different hashes for different permutations of string' do
      a = ('a'..'z').to_a
      b = a.shuffle
      expect(a.join.my_hash).not_to eq(b.join.my_hash)
    end

    it 'should produce different values for subarrays' do
      a = 'string'
      b = 'substring'
      expect(a.my_hash).not_to eq(b.my_hash)
    end
  end

  describe Hash do
    it 'hashes to an integer' do
      expect({a: 'a'}.my_hash).to be_a(Integer)
    end

    it 'hashes determinisctically' do
      a = { a: 'a', b: 'b' }
      expect(a.my_hash).to eq(a.my_hash)
    end

    it 'produces same hash for two identical hashes' do
      a = { a: 'a', b: 'b' }
      b = { a: 'a', b: 'b' }
      expect(a.my_hash).to eq(b.my_hash)
    end

    it 'produces same hash for permutation of same hash' do
      a = { a: 'a', b: 'b' }
      b = { b: 'b', a: 'a' }
      expect(a.my_hash).to eq(b.my_hash)
    end

    it 'produces different hashes for subsets of hash' do
      a = { a: 'a', b: 'b' }
      b = { b: 'b '}
      expect(a.my_hash).not_to eq(b.my_hash)
    end
  end

end
