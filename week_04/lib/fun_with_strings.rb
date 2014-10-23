module FunWithStrings
  def palindrome?
    return self.gsub(/\W+/,"").upcase.reverse == self.gsub(/\W+/,"").upcase
  end

  def count_words
    hash = Hash.new(0)
    self.chomp.split(/\W+/).each do |element|
      if element == "" ; next ;end
       hash[element.downcase] += 1
    end
    return hash
  end

  def anagram_groups
    if self.empty?
        return Array.new
    end
    words = self.split(/\W+/)
  end
end

# make all the above functions available as instance methods on Strings:

class String
  include FunWithStrings
end
