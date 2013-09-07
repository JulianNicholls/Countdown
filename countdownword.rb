#----------------------------------------------------------------------------
# Hold a countdown candidate word, and its letter map which holds a count of
# each character it contains

class CountdownWord

  attr_reader :word   # Only necessary for the comparison operator

  # Initialize with the word, defaults to lazy evaluation of the letter map.
  
  def initialize( word, map_word = false )
    @word = word
    @wmap = map_word ? letter_map( word ) : {}
  end

  
  # Return whether the current word could be built from the letter map
  # that is passed in. e.g.
  #
  # belabour could be built from 'belbaoura' because
  #
  #   { b: 2, e: 1, l: 1, a: 1, o: 1, u: 1, r: 1} (map for belabour, see below) matches with
  #   { b: 2, e: 1, l: 1, a: 2, o: 1, u: 1, r: 1} (map for 'belbaoura')
  #
  # in that the number of every character in the word appears in the candidate lettermap 
  
  def can_be_made_from( cand )
    # If the current word hasn't been lettermap'ed yet, then do it now and 
    # store it for next time.
    
    @wmap = CountdownWord::lettermap( @word ) if @wmap.empty?  
    
    # Work through the word, checking if the candidate letters could build it.
    
    @wmap.keys.each do |l|
      # If the letter list either doesn't have any of the current letter, 
      # or not enough, then it can't be made from those letters
      
      return false if cand[l].nil? || cand[l] < @wmap[l]  
    end
    
    true  # To have fallen through here, it must be possible
  end
  
  
  # Return the word so that it can be easily output via print/puts
  
  def to_s
    @word
  end
  
  
  # Perform a comparison, by decreasing length, then alphabetically
  
  def <=>( b )
    comp = b.word.length - @word.length
    
    if comp == 0        # Same length, sort alphabetically
      return -1 if @word < b.word
      return 1  if @word > b.word
      
      return 0
    end
  
    # One or other is longer, so return that
    
    (comp < 0) ? -1 : 1
  end
  
  
  # This is the key to the whole thing. It returns a map of the used letters, thus:
  # Word      Map
  # belabour  { b: 2, e: 1, l: 1, a: 1, o: 1, u: 1, r: 1}
  # resonate  { r: 1, e: 2, s: 1, o: 1, n: 1, a: 1, t: 1 }
  
  def self.lettermap( word )
    m = {}    # Empty map
    
    word.each_char do |l| 
      m[l] = 0 if m[l].nil?   # Add new letter
      m[l] += 1               # Count 1 more
    end
    
    m         # Return map
  end
  
end
