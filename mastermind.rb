class ComputerPlayer
    def initialize
        @secret_colors = %w[blue yellow red green orange purple].sample(4)
        @correct_computer_choices = ['incorrect', 'incorrect', 'incorrect', 'incorrect']
        @correct_computer_color_choices = []
        @correct_computer_color_choices_selector = []
        @remaining_computer_choices = ['blue', 'yellow', 'red', 'green', 
                              'orange', 'purple']
        @remaining_computer_choices_selector = []
    end

    def computer_code_breaker
        12.times do
            correct_color_space = 0
            correct_color = 0
            break if @game == 'won'
            p codeMaker.secret_colors
            p correct_computer_color_choices
    
            # Process for computer player to make 4 selections 
            if correct_computer_choices == ['incorrect', 'incorrect', 'incorrect', 'incorrect'] && correct_computer_color_choices == []
               p computer_choices = %w[blue yellow red green orange purple].sample(4)
            else 
              computer_choices = correct_computer_choices
              correct_computer_color_choices_selector = correct_computer_color_choices
              remaining_computer_choices_selector = remaining_computer_choices
              if correct_computer_color_choices_selector != []
                while correct_computer_color_choices_selector != [] do
                   computer_choice_index = rand(0..3)
                  if correct_computer_choices[computer_choice_index] != 'incorrect'
                    next
                  else  
                    if computer_choices[computer_choice_index] = 'incorrect'
                      computer_choices[computer_choice_index] = correct_computer_color_choices_selector.sample(1).join
                      correct_computer_color_choices_selector.delete(computer_choices[computer_choice_index])
                      remaining_computer_choices_selector.delete(computer_choices[computer_choice_index])
                    end
                  end
                end
              end
              computer_choices.each_with_index do |color, index|
                if color == 'incorrect'
                  double_color_check = remaining_computer_choices_selector.sample(1).join
                  p double_color_check
                  remaining_computer_choices_selector.delete(double_color_check)
                  computer_choices[index] = double_color_check
                end
              end
              p computer_choices
            end
            codeMaker.secret_colors.each_with_index do |secret_color, index|
              if secret_color == computer_choices[index]
                correct_color_space += 1
                correct_computer_choices[index] = secret_color
                remaining_computer_choices.delete(secret_color)
                if correct_computer_color_choices.include?(secret_color)
                  correct_computer_color_choices.delete(secret_color)
                end
              else
                codeMaker.secret_colors.each do |secret_color|
                  if computer_choices[index] == secret_color  
                  correct_color += 1 
                    unless correct_computer_color_choices.include?(secret_color)
                      correct_computer_color_choices.push(secret_color)
                    end  
                  end
                end
              end
            end
            codeMaker.secret_colors.each_with_index do |secret_color, index|
              if secret_color != computer_choices[index]
                correct_computer_choices[index] = 'incorrect'
              end
            end  
            if correct_color_space == 4
              @game = 'won'
              puts '4 correct choices! The computer wins!'
              break
            else
              puts "There were #{correct_color_space} choices with the correct color and correct space selected. #{correct_color} choices had the correct color, but the incorrect space was picked"
              correct_color_space = 0
              correct_color = 0
            end
        end
    end


end

class HumanPlayer
    attr_accessor :secret_colors
  
    def initialize
        @secret_colors = []
    end
  #sets secret code for human player
    def human_secret_colors
      4.times do |index|
        puts "What color do you want to choose for peg #{index + 1}?"
        choice = gets.chomp.downcase
        if choice != 'blue' && choice != 'red' && choice != 'green' && choice != 'yellow' && choice != 'orange' && 
        choice != 'purple'
          puts "That's not one of the color options. Please choose either blue, yellow, red, green, orange, or purple"
          puts "What color do you want to choose for peg #{index + 1}?"
          choice = gets.chomp.downcase
        end
        @secret_colors.push(choice)
      end
    end

    def human_code_breaker
        12.times do
            correct_color_space = 0
            correct_color = 0
            break if @game == 'won'
    
            4.times do
              codeMaker.secret_colors.each_with_index do |secret_color, index|
                puts "What color do you want to choose for peg #{index + 1}?"
                choice = gets.chomp.downcase
                if choice != 'blue' && choice != 'red' && choice != 'green' && choice != 'yellow' && choice != 'orange' && 
                choice != 'purple'
                  puts "That's not one of the color options. Please choose either blue, yellow, red, green, orange, or purple"
                  puts "What color do you want to choose for peg #{index + 1}?"
                  choice = gets.chomp.downcase
                end
                if choice == secret_color
                  correct_color_space += 1
                else
                  codeMaker.secret_colors.each do |secret_color|
                    correct_color += 1 if choice == secret_color
                  end
                end
              end
              if correct_color_space == 4
                @game = 'won'
                puts 'You win!'
                break
              else
                puts "There were #{correct_color_space} choices with the correct color and correct space selected. #{correct_color} choices had the correct color, but the incorrect space was picked"
                correct_color_space = 0
                correct_color = 0
              end
            end
        end
    end
  end
  
  class Board
    attr_accessor :game
    def initialize
      @game = ''
    end
  #lets human player decide whether they want to be the codemaker or codebreaker
    def start_game(codeMaker)
      puts "Mastermind is a code breaking game with two players. In this version of the game, only one player is a person while the other is a computer. The game board has 12 rows of 4 holes, where 4 colored pegs can be placed. There are 6 available colors to choose, which are blue, red, green, yellow, orange, and purple. The codemaker chooses 4 different colors to place in 4 spots. The codebreaker has 12 turns to guess the correct order in which the colors are placed. If all 4 colors are guessed in the correct position, the codebreaker wins."
      puts 'Would you like to be the codebreaker or the codemaker?'
      code_choice = gets.chomp.downcase
      if code_choice != 'codemaker' && code_choice != 'codebreaker'
        puts "That's not one of the choices."
        start_game(codeMaker)
      elsif code_choice == 'codemaker'
        codeMaker.human_secret_colors
      end
    end
  end
  
  board = Board.new
  
  board.start_game(coder)