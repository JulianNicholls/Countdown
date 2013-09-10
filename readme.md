# Countdown

This is a word finder for the UK (originally French) TV gameshow 
[Countdown](http://en.wikipedia.org/wiki/Countdown_%28game_show%29).

## Word list

It uses a word list constructed from
Kevin Atkinson's [wordlist page](http://wordlist.sourceforge.net/). 
I have included the whole copyright file that comes with the download, since
all the component word lists have ultimately been placed in the public domain, 
but there are a number of different statements of copyright contained. Clearly,
I am deeply in Kevin's debt for the word list and acknowledge the sterling work
that he has done.

The word list that I have chosen to construct from his files is:

- Level 80, with...
- English and British up to variant 1.
- No possessives ('s), abbreviations, proper names, Roman numerals, or hacker words. 
- Word lengths 5 to 9.

I'd say that the word list seems to be at about the right level, because 
when Susie Dent uses the pen camera on the dictionary, the word has so far 
been found by this program as one of the longest words.

## Bonuses

It only occurred to me while I was watching my first Countdown after I 
developed this, that it works just as well for:

- The teatime teasers at the end of each segment.
- The final conundrum round.

It will also work for crossword anagrams, as long as the solution is one word
of 9 letters, at most.

### Operator <=> overloading

The definition for the <=> operator in built-in classes explicitly states that 
it returns -1, 0, and +1 for the three comparison possibilities.

It seems that overriding the operator only requires that the return value is \<0, 0, or \>0.
I couldn't find this documented anywhere on the net after much searching, but 
I tried it in the end and it seems to work for sort().

Subsequently, I looked at the source code for ruby_qsort() and the comparisons 
made are all against 0, so a negative, zero, or positive quantity is fine.
