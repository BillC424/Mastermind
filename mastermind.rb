class Player

end

class CodeMaker < Player
  attr_accessor :secret_colors
  
  def initialize
    @secret_colors = ['blue', 'yellow', 'red', 'green', 'orange', 'purple'].sample(4)
  end
end

class CodeBreaker < Player

end

class Board
  attr_accessor :game
  def initialize 
    @game = ''
  end
    
  def play_game(codeMaker)
    12.times do  
      correct_color_space = 0 
      correct_color = 0
      if @game == 'won'
        break
      end
      4.times do
        codeMaker.secret_colors.each_with_index do |secret_color, index|
          puts "What color do you want to choose for peg #{index + 1}?"
          choice = gets.chomp.downcase
          if choice == secret_color
            correct_color_space += 1
          else 
            codeMaker.secret_colors.each do |secret_color|
              if choice == secret_color
                correct_color += 1
              end
            end
          end
        end
       if correct_color_space == 4
         @game = 'won'
         puts 'You win!'
         break
       else  
       puts "There were #{correct_color_space} choices with the correct color and correct space selected. #{correct_color} choices had the correct color, but the incorrect space was picked"
       p codeMaker.secret_colors
       correct_color_space = 0 
       correct_color = 0
       end
      end  
    end
  end
end

board = Board.new
coder = CodeMaker.new

board.play_game(coder)
