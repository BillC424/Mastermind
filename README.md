# Mastermind
https://www.theodinproject.com/lessons/ruby-mastermind

Command line based Mastermind game (https://en.wikipedia.org/wiki/Mastermind_(board_game)) between a human player and a computer player. The human player can choose to be either a codemaker or a codebreaker. 

This version of the game involves a codemaker choosing four different colors to be in 4 different positions. The codebreaker then attempts to guess all 4 colors in the correct positions. If the codebreaker guesses the correct color/position, they get feedback in the console informing them how many correct color/position choices they made. If they choose a color that is one of the 4 codemaker choices but in the incorrect position, the console gives them feedback on how many incorrect position/correct color choices they made.

When playing as the codebreaker, the computer player has logic to retain choices that are in the correct position/color and to include colors in future rounds that were chosen in previous rounds, but were in the incorrect spot.

Live demo at: https://replit.com/@BillC424/mastermind-2#main.rb

Built using Ruby. From The Odin Project curriculum (https://www.theodinproject.com/)
