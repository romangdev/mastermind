# Mastermind
A command line based replication of the game Mastermind.

![2022-06-19 14 38 14](https://user-images.githubusercontent.com/74276666/174495899-e3889513-5c28-4b1c-bf41-b296c1024826.gif)

# How It's Made:
Tech used: Ruby, lots of grit and tears

This entire application is built using Ruby, and is meant to be played in the command line. The human player can choose to either be the codebreaker or the codemaker. The computer is automatically assigned to the opposite role. If the human is the codemaker, they will get to create their code of 4 colors out of 6 (with repeats allowed). The computer has 12 attempts to guess the correct pattern of colors. The computer knows when it has guessed a correct color and position, and will continue to guess that same color/position. It also knows if it's guessed a correct color in the wrong position, and will continually guess that same color in different positions until it's correct. 

If the human is instead the codebreaker, the computer will create a random code within the same rule constraints, and the human player will have 12 turns to guess the code. 

No matter what role the human player takes, a full game board showing previous code guesses, and code guess feedback in the form of key pegs indicating how close one's guess lines up with the actual code will be displayed. 

# Optimizations
This was my second large project utilizing OOP. If more time had allowed, I would refactor the structure of methods within my classes. I have instance methods spanning several dozens of lines of code that can certainly be broken up. Additionally, I'm  aware many of the methods for the computer solving code are not nearly as efficient as they could be. I'd certainly spend a good bit of time improving those as well. Additionally, I would have the computer solve the code the same way a player would, using the same strategies, rather than being able to "cheat" by knowing exactly which colors were guessed in a correct position, or which colors were correct but in a wrong position. 

# Lessons Learned:
This project really taught me the value of pseudocode and planning well in advance. It also boosted my confidence and my ability to perservere through difficult problems. There were several points when coding instance methods for the computer class that I came close to skipping over some implementation I really wanted it to have, and just moving on... because it was so frustrating/difficult to solve. But eventually, I did solve every problem I set out to, even if it may not have been the most efficient. I also ran into some issues that could've been prevented if I planned out the "big picture" of the program better. But alas, lessons learned. 

P.S. I also learned that 80% of the time I think some difficult I've "solved" is finally working... it probably isn't... and I will discover some exception 1 hour later, haha!
