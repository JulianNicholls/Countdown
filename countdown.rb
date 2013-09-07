require './countdownwordlist'

# Load the words from the word list file

print "Loading... "

list = CountdownWordList.new

# Display the number of words for each initial letter, there's 143K in total.

puts
list.debug

again = true

while again
  # Get the letters that the contestant has chosen

  print "\nLetters: "
  letters = gets.chomp.downcase

  # Search for words that can built from the letters
  
  print "\nSearching... "
  
  cur_len = 10
  
  # List all the words, splitting them into lists of words with the same 
  # number of letters
  
  list.words_from( letters ).each do |w|
    w = w.to_s
    if w.length < cur_len   # Word length has changed, start a new list
      cur_len = w.length
      print "\n\n#{cur_len} Letters: "
    end
    
    print "#{w}, "
  end

  # Ask the user if they want to go again
  
  yesno = 'q'
  
  while !('YN'.include? yesno)
    print "\n\nAgain? "
    yesno = gets[0].upcase
  end
  
  again = (yesno == 'Y')
end

