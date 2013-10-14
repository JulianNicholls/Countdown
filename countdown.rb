require "term/ansicolor"

require './countdownwordlist'

include Term::ANSIColor

class CountdownSession

  #----------------------------------------------------------------------------
  # Load the words from the word list file

  def initialize
    print yellow { bold { "Loading... " } }

    @list = CountdownWordList.new

    # Display the number of words for each initial letter, there's 143K in total.

    puts
    @list.debug
  end


  #----------------------------------------------------------------------------
  # Get the letters from the user

  def get_letters
    @letters = ''
    
    while @letters.length < 8
      print cyan { bold { "\nLetters: " } }
      @letters = gets.strip.downcase
    end
  end


  #----------------------------------------------------------------------------
  # Search for words in the list that can be built from the letters

  def search
    print red { bold { "\nSearching... " } }
    
    start     = Time.now
    @wordlist = @list.words_from( @letters )
    finish    = Time.now
    
    printf red { bold { "%.3fs, %d Words" } },  finish - start, @wordlist.length
  end
  
  
  #----------------------------------------------------------------------------
  # Ask if the user wants to enter more letters
  
  def go_again
    yesno = 'q'
  
    until 'YN'.include? yesno
      print yellow { bold { "\n\nAgain? " } }
      yesno = gets[0].upcase
    end
    
    yesno == 'Y'
  end
  
  #----------------------------------------------------------------------------
  # Show the list of buildable words.

  def show
    @wordlist.chunk { |w| w.to_s.length }.each do |arr|
      length, words = arr
      
      print yellow { bold { "\n\n#{length} Letters: " } }
      column = 11
      
#      puts words.inject('') do
      words.each do |w|
        print cyan { bold { "#{w}, " } }
        column += length + 2
        if column > 77 - length
          puts
          column = 0
        end
      end
    end
  end
end

#----------------------------------------------------------------------------
# Start here

session = CountdownSession.new

again = true

while again
  session.get_letters          # Get the letters that have been chosen
  session.search               # Search for what can be built from them
  session.show                 # List all the words, split by length
  again = session.go_again     # Ask the user if they want to go again
end
