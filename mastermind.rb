class Player

end

class CodeMaker < Player
  def initialize
    @secret_colors = ['blue', 'yellow', 'red', 'green', 'orange', 'purple'].sample(4)
  end
end

class CodeBreaker < Player

end

class Board
  
  def play_game
    12.times do 
      puts “What color do you want to choose for peg #{number}?”
      gets.chomp
    end
  end
  
end