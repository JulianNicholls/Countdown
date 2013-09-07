require './countdownwordlist'

print "Loading... "

list = CountdownWordList.new

puts
list.debug

again = true

while again
  print "\nLetters: "
  letters = gets.chomp.downcase

  print "\nSearching... "
  
  cur_len = 10
  
  list.words_from( letters ).each do |w|
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

