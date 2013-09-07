class CountdownWord

  attr_reader :word

  def initialize( word, map_word = true )
    @word = word
    @wmap = map_word ? letter_map( word ) : {}
  end

  def can_be_made_from( lettersmap )
    @wmap = CountdownWord::letter_map( @word ) if @wmap.empty?
    @wmap.keys.each do |l|
      return false if lettersmap[l].nil? || lettersmap[l] < @wmap[l]
    end
    
    true  # To have fallen through here, it must be possible
  end
  
  def to_s
    @word
  end
  
  def <=>( b )
    comp = b.word.length - @word.length
    
    if comp == 0   # Same length, sort alphabetically
      if @word < b.word
        return -1
      elsif @word > b.word
        return 1
      else
        return 0
      end
    end
  
    # One or other is longer
    
    (comp < 0) ? -1 : 1
  end
  
  def self.letter_map( word )
    m = {}
    
    word.each_char do |l| 
      m[l] = 0 if m[l].nil?
      m[l] += 1
    end
    
    m
  end
  
end

class WordList

  def initialize( filename = nil )
    fn     = filename || 'words.txt'
    @words = {};
        
    File.foreach( fn ) do |line|
      idx = line[0]
      
      @words[idx] = Array.new if @words[idx].nil?
      @words[idx] << CountdownWord.new( line.chomp(), false )
    end
  end
  
  def words_from( letters )
    uniqs = letters.split(//).uniq
    lmap  = CountdownWord::letter_map( letters )
    
    uniqs.map do |l| 
      @words[l].select { |w| w.can_be_made_from( lmap ) }
    end
  end
    
  def debug
    @words.each_key { |ltr| puts "#{ltr}: #{@words[ltr].length}" }
  end

end

print "Loading... "

list = WordList.new

list.debug

again = true

while again
  print "\nLetters: "
  letters = gets.chomp.downcase

  print "\nSearching... "
  
  cur_len = 10
  
  list.words_from( letters ).flatten.sort.each do |w|
    w = w.to_s
    if w.length < cur_len
      cur_len = w.length
      print "\n\n#{cur_len} Letters: "
    end
    
    print "#{w}, "
  end

  yesno = 'q'
  
  while !('YN'.include? yesno)
    print "\n\nAgain? "
    yesno = gets[0].upcase
  end
  
  again = (yesno == 'Y')
end

