# Part 1

def unique_array(a)
  a.uniq
end

def two_sum?(a, n)

  # We use a hash to store a mapping of complement to index.
  index_hash = {}

  a.each_with_index do |num, index|
    # If the current numbers isn't in the hash, add its complement to the hash along with the current index.
    # This way if the complement does come up later, we know both the indices we need.
    if index_hash[num].nil?
      index_hash[n - num] = index
    else
      # Since the current number is already in the hash, it means current number's complments has been traversed.
      return true
    end
  end
  # Return false if there are no two numbers whose sum is n.
  false
end

def group_anagrams(a)

  #Sort the characters in every string in ascending order
  char_sorted_a = a.map {|word| word.chars.sort.join}

  # Create an empty hash of arrays.
  word_hash = Hash.new {|h, k| h[k] = []}

  # Store a mapping of sorted character strings to indices.
  # Since we have sorted the characters, all anagrams map to same string.
  char_sorted_a.each_with_index {|word, index| word_hash[word] << index}

  # Get values associated with the indices from the array a and return the array of arrays.
  word_hash.values.map {|index_array|
    index_array.map {|index|
      a[index]
    }
  }

end

# Part 2

def palindrome?(s)
  s.upcase == s.reverse.upcase
end

def remove_and_append_vowels(s)
  s.gsub(/[aeiouAEIOU]/, "") << s.scan(/[aeiouAEIOU]/).join
end

def highest_frequency_word(s)
  word_hash = Hash.new(0)
  s.each {|word|
    word_hash[word.downcase] += 1
  }
  max_count = word_hash.values.max
  word_hash.find {|k, v| v == max_count}.first.downcase
end

# Part 3

class Book
  attr_accessor :name, :price
  DOLLARS = "dollars"
  CENTS = "cents"

  def initialize(name, price)
    raise ArgumentError, "Name cannot be empty or nil" if name.nil? || name == ""
    raise ArgumentError, "Price cannot be nil or zero or negative" if price.nil? || price <= 0
    @name = name
    @price = price
  end

  def formatted_price
    dollar_value = @price.to_i
    cents_value = (@price.modulo(1).round(2) * 100).to_i
    # The final text will includes the "and" word only if both dollars and cents have a value
    and_text = (dollar_value != 0 && cents_value != 0) ? "and " : ""

    get_formatted_text(dollar_value, DOLLARS) + and_text + get_formatted_text(cents_value, CENTS) + "only"
  end
end

def get_formatted_text(value, unit)
  # If value is 1, remove the s from end of the unit.
  unit_text = value == 1 ? "#{unit.gsub(/s$/, '')} " : "#{unit} "

  # If the current denomination is 0, return empty string, else return the appropriate text.
  value == 0 ? "" : "#{value} #{unit_text}"
end
