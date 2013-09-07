#----------------------------------------------------------------------------
# Hold a list of countdown words.
#
# It is held as a hash of arrays, indexed by the initial letter, so that 
# searching for candidate words from a set of letters only has to search 
# through the set of words that start with each unique letter.
#
# The maximum number of words to search is 87K of the 143K words (61%).
# if the following letters were chosen: abcdfmpst
# That's a pretty unlikely set to choose, but it does elicit 7 five letter 
# words.

require './countdownword'

class CountdownWordList

  # Initialise the array from a word list file, defaulting to cwords.txt
  
  def initialize( filename = nil )
    fn     = filename || 'cwords.txt'
    @words = {};
        
    File.foreach( fn ) do |line|
      idx = line[0]
      
      @words[idx] = Array.new if @words[idx].nil?
      @words[idx] << CountdownWord.new( line.chomp(), false )
    end
  end
  
  # Get the list of words that can be built from the passed letters
  
  def words_from( letters )
    # Find the unique letters, and also built the letter map for the letters.
    
    uniqs = letters.split(//).uniq
    lmap  = CountdownWord::lettermap( letters )
    
    # Work through the unique letters, testing each word in the letter lists
    # against the passed letters
    
    list = uniqs.map do |l| 
      @words[l].select { |w| w.can_be_made_from( lmap ) }
    end
    
    # Flatten out the resulting array of arrays resulting from map, and sort 
    # by length, longest first
    
    list.flatten.sort
  end
    
  # Show the number of words in each letter section of the hash.
  
  def debug
    @words.each_key { |ltr| puts "#{ltr}: #{@words[ltr].length}" }
  end

end

