#! /usr/bin/env ruby -I.

require 'term/ansicolor'

require 'countdownwordlist'

# Run a text Countdown solving session
class CountdownSession
  include Term::ANSIColor

  #----------------------------------------------------------------------------
  # Load the words from the word list file

  def initialize(filename)
    print yellow, bold { 'Loading... ' }

    @list = CountdownWordList.new filename

    # Display the number of words for each initial letter, 143K in total.

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

# Handle output of a word, keeping track of the output column
class WrappingOutput
  def initialize(line_length = 80, column = 0)
    @line_length = line_length
    @column = column
  end

  def print(*args)
    @output = *args
    Kernel.print(*args)
    update_column
  end

  private

  def update_column
    @column += output_length

    return if @column <= 79 - output_length

    puts
    @column = 0
  end

  # Calculate the length, ignoring escape sequences
  def output_length
    @output.each.reduce(0) do |acc, item|
      acc + ((/\A\e\[.*m\z/ =~ item) ? 0 : item.length)
    end
  end
end

#----------------------------------------------------------------------------
# Start here

session = CountdownSession.new(ARGV[0] || 'cwords.txt')

loop do
  session.enter_letters         # Get the letters that have been chosen
  session.search                # Search for what can be built from them
  session.show                  # List all the words, split by length
end
