# Hold a countdown candidate word, and its letter map which holds a count of
# each character it contains
class CountdownWord
  # This is the key to the whole thing. It returns a map of the used letters,
  # thus:
  #   Word      Map
  #   belabour  { b: 2, e: 1, l: 1, a: 1, o: 1, u: 1, r: 1 }
  #   resonate  { r: 1, e: 2, s: 1, o: 1, n: 1, a: 1, t: 1 }

  attr_reader :wmap

  def self.lettermap(word)
    # Empty map with automatic 0s
    lmap = Hash.new(0)

    word.each_char { |let| lmap[let] += 1 }

    lmap
  end

  # Initialize with the word, with no evaluation of the letter map.

  def initialize(word)
    @word = word.downcase
  end

  # Return whether the current word could be built from the letter map
  # that is passed in. e.g.
  #
  # belabour could be built from 'belbaoura' because
  #
  #   { b: 2, e: 1, l: 1, a: 1, o: 1, u: 1, r: 1} (map for belabour) matches
  #   { b: 2, e: 1, l: 1, a: 2, o: 1, u: 1, r: 1} (map for 'belbaoura')
  #
  # in that the number of every character in the word appears in the candidate
  # lettermap.

  def can_be_made_from(candidate)
    candidate = candidate.wmap if candidate.respond_to? :wmap

    # If the current word hasn't been lettermap'ed yet, then do it now and
    # store it for next time.

    @wmap ||= CountdownWord.lettermap(@word)

    # Work through the word, checking if the candidate letters could build it.

    @wmap.each_key do |let|
      # If the letter list either doesn't have any of the current letter,
      # or not enough, then it can't be made from those letters.

      return false unless candidate.key?(let) && candidate[let] >= @wmap[let]
    end

    # To have fallen through here, it must be possible
    true
  end

  # Return the word so that it can be easily output via print/puts

  def to_s
    @word
  end

  # Perform a comparison, by decreasing length, then alphabetically.
  # See readme.md for an interesting aside about operator <=>

  def <=>(other)
    other = other.to_s
    comp  = other.length - @word.length

    return comp unless comp == 0    # Return which is longer

    @word < other ? -1 : 1          # Same length, sort alphabetically
  end

  def uniques
    @wmap.keys
  end
end

# Word holder which initializes te letter map on creation.
class InitializedCountdownWord < CountdownWord
  def initialize(word)
    super
    @wmap = CountdownWord.lettermap(@word)
  end
end
