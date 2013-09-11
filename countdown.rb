require './countdownwordlist'

#----------------------------------------------------------------------------
# Load the words from the word list file

def load_wordlist
  print "Loading... "

  list = CountdownWordList.new

  # Display the number of words for each initial letter, there's 143K in total.

  puts
  list.debug
  
  list
end

#----------------------------------------------------------------------------
# Get the letters from the user

def get_letters
  letters = ''
  
  while letters.length < 8
    print "\nLetters: "
    letters = gets.strip.downcase
  end
  
  letters
end

#----------------------------------------------------------------------------
# Search for words in the list that can be built from the letters

def search( list, letters )
  print "\nSearching... "
  
  start    = Time.now
  wordlist = list.words_from( letters )
  finish   = Time.now
  
  printf "%.3fs, %d Words",  finish - start, wordlist.length
  
  wordlist
end

#----------------------------------------------------------------------------
# Show the list of buildable words.

def show list
  cur_len = 10
  column  = 0
  
  list.each do |w|
    w = w.to_s
    
    if w.length < cur_len   # Word length has changed, start a new sub-list
      cur_len = w.length
      print "\n\n#{cur_len} Letters: "
      column = 11
    end
    
    print "#{w}, "
    column += cur_len + 2
    if column > 77 - cur_len
      puts
      column = 0
    end
  end
end

#----------------------------------------------------------------------------
# Ask if the user wants to enter more letters

def go_again
  yesno = 'q'
  
  until 'YN'.include? yesno
    print "\n\nAgain? "
    yesno = gets[0].upcase
  end
  
  yesno == 'Y'
end

#----------------------------------------------------------------------------
# Start here

list = load_wordlist

again = true

while again
  letters  = get_letters              # Get the letters that have been chosen
  thewords = search( list, letters )  # Search for what can be built from them
  show thewords                       # List all the words, split by length
  again = go_again                    # Ask the user if they want to go again
end


