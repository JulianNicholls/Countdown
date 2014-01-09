require 'term/ansicolor'

require './countdownwordlist'

# Run a text Countdown solving session

class CountdownSession
  include Term::ANSIColor

  #----------------------------------------------------------------------------
  # Load the words from the word list file

  def initialize
    print yellow { bold { 'Loading... ' } }

    @list = CountdownWordList.new

    # Display the number of words for each initial letter, there's 143K in total.

    puts
    @list.debug
  end

  #----------------------------------------------------------------------------
  # Get the letters from the user

  def enter_letters
    loop do
      print cyan { bold { "\nLetters: " } }
      @letters = gets.strip.downcase
      break if @letters.length >= 8
    end
  end

  #----------------------------------------------------------------------------
  # Search for words in the list that can be built from the letters

  def search
    print red { bold { "\nSearching... " } }

    start     = Time.now
    @wordlist = @list.words_from( @letters )
    finish    = Time.now

    printf red { bold { '%.3fs, %d Words' } },  finish - start, @wordlist.length
  end

  #----------------------------------------------------------------------------
  # Ask if the user wants to enter more letters

  def go_again
    yesno = ''

    loop do
      print yellow { bold { "\n\nAgain? " } }
      yesno = gets[0].upcase
      break if 'YN'.include? yesno
    end

    yesno == 'Y'
  end

  #----------------------------------------------------------------------------
  # Show the list of buildable words.

  def show
    @wordlist.chunk { |w| w.to_s.length }.each do |arr|
      length, words = arr

      print yellow { bold { "\n\n#{length} Letters: " } }

      list( words )
    end
  end

  def list( words )
    column  = 11
    length  = words.first.to_s.size

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

#----------------------------------------------------------------------------
# Start here

session = CountdownSession.new

loop do
  session.enter_letters         # Get the letters that have been chosen
  session.search                # Search for what can be built from them
  session.show                  # List all the words, split by length
  break unless session.go_again # Ask the user if they want to go again
end
