require './countdownword'

#----------------------------------------------------------------------------
# Hold a list of countdown words.
#
# It is held as a hash of arrays, indexed by the initial letter, so that
# searching for candidate words from a set of letters only has to search
# through the set of words that start with each unique letter.
#
# The maximum number of words to search is 87K of the 143K words (61%).
# if the following letters were chosen: abcdfmpst
# That's a pretty unlikely (not to mention against the rules of Countdown)
# set to choose, but it does elicit 7 five letter words.
class CountdownWordList
  # Initialise the array from a word list file, defaulting to cwords.txt
  # using magic hash key array creation thing learnt from Ruby Koans

  def initialize(filename = nil)
    @words = Hash.new { |hash, key| hash[key] = [] }
    @lengths = Array.new(20, 0)
    load filename
  end

  def load(filename)
    File.foreach(filename) { |line| add line.chomp }
  end

  # Get the list of words that can be built from the passed letters

  def words_from(letters)
    # Find the unique letters, and also build the letter map for the letters.

    @candidate_word = InitializedCountdownWord.new letters

    # Work through the unique letters, testing each word in the letter lists
    # against the passed letters

    list = @candidate_word.uniques.map { |let| search let }

    # Flatten out the array of arrays resulting from map, and sort by length,
    # longest first

    list.flatten.sort
  end

  # Show the number of words in each letter section of the hash and also the
  # number of each length of word.

  def debug
    @words.each_key { |ltr| printf "%c: %5d\n", ltr.upcase, @words[ltr].length }
    puts
    @lengths.each_with_index do |num, idx|
      printf("%2d-letter words: %5d\n", idx, num) if num > 0
    end
  end

  private

  def add(word)
    @words[word[0].downcase] << InitializedCountdownWord.new(word)
    @lengths[word.size] += 1
  end

  def search(letter)
    @words[letter].select { |word| word.can_be_made_from(@candidate_word) }
  end
end
