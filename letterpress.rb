#! /usr/bin/env ruby -I.

require 'term/ansicolor'

require 'countdownwordlist'
require 'output_wrapper'
require 'confirmation'

# Run a text Countdown solving session
class LetterpressSession
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
      break if @letters.length >= 20

      print 'Not enough for a Letterpress game'
    end
  end

  #----------------------------------------------------------------------------
  # Search for words in the list that can be built from the letters

  def search
    system('clear')

    print red, bold, "\n#{@letters.upcase} (#{@letters.size}) - Searching... "

    @wordlist = @list.words_from(@letters)

    printf "#{@wordlist.length} Words", reset
  end

  # :reek:NestedIterators = Two is fine AFAIC
  def save
    filename = "letterpress/#{@letters[0, 5]}.txt"

    if !File.exist?(filename) || Confirm.ask('Overwrite')
      open(filename, 'w') do |file|
        @wordlist.each_slice(10) { |ten| file.puts ten.join ', ' }
      end
    end

    puts "#{filename} written"
  end

  #----------------------------------------------------------------------------
  # Show the list of buildable words.

  def show
    @wordlist.chunk { |word| word.to_s.length }.each do |length, words|
      print yellow, bold, "\n\n#{length} Letters: ", reset

      list(words)
    end

    puts
  end

  def list(words)
    output = WrappingOutput.new(150, 11)

    words.each { |word| output.print bright_cyan, "#{word}, " }
  end
end


#----------------------------------------------------------------------------
# Start here

session = LetterpressSession.new(ARGV[0] || 'letterpress.words')

loop do
  session.enter_letters         # Get the letters that have been chosen
  session.search                # Search for what can be built from them
  session.show                  # List all the words, split by length
  session.save if Confirm.ask 'Save words'
end
