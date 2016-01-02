#! /usr/bin/env ruby -I.

require 'term/ansicolor'

require 'countdownwordlist'
require 'output_wrapper'

# Run a text Countdown solving session
class CountdownSession
  include Term::ANSIColor

  #----------------------------------------------------------------------------
  # Load the words from the word list file

  def initialize(filename)
    print yellow, bold { 'Loading... ' }

    @list = CountdownWordList.new filename

    # Display the number of words for each initial letter.

    puts
    @list.debug
  end

  #----------------------------------------------------------------------------
  # Get the letters from the user

  def enter_letters
    loop do
      print bright_cyan, "\n\nLetters: ", white
      @letters = $stdin.gets.strip.downcase
      break if @letters.length >= 8
    end
  end

  #----------------------------------------------------------------------------
  # Search for words in the list that can be built from the letters

  def search
    system('clear')

    print red, bold, "\n#{@letters.upcase} - Searching... "

    @wordlist = @list.words_from(@letters)

    printf "#{@wordlist.length} Words", reset
  end

  #----------------------------------------------------------------------------
  # Show the list of buildable words.

  def show
    @wordlist.chunk { |word| word.to_s.length }.each do |length, words|
      print yellow, bold, "\n\n#{length} Letters: ", reset

      list(words)
    end
  end

  def list(words)
    output = WrappingOutput.new(80, 11)

    words.each { |word| output.print bright_cyan, "#{word}, " }
  end
end

#----------------------------------------------------------------------------
# Start here

session = CountdownSession.new(ARGV[0] || 'countdown.words')

loop do
  session.enter_letters         # Get the letters that have been chosen
  session.search                # Search for what can be built from them
  session.show                  # List all the words, split by length
end
