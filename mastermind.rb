class CodeMaker
    attr_accessor :secret_colors
  
    def initialize
      @secret_colors = %w[blue yellow red green orange purple].sample(4)
    end
  
    def human_secret_colors
      @secret_colors = []
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
  end
  
  class Board
    attr_accessor :game
    def initialize
      @game = ''
    end
  
    def play_game(codeMaker)
      puts "Mastermind is a code breaking game with two players. In this version of the game, only one player is a person while the other is a computer. The game board has 12 rows of 4 holes, where 4 colored pegs can be placed. There are 6 available colors to choose, which are blue, red, green, yellow, orange, and purple. The codemaker chooses 4 different colors to place in 4 spots. The codebreaker has 12 turns to guess the correct order in which the colors are placed. If all 4 colors are guessed in the correct position, the codebreaker wins."
      puts 'Would you like to be the codebreaker or the codemaker?'
      code_choice = gets.chomp.downcase
      if code_choice != 'codemaker' && code_choice != 'codebreaker'
        puts "That's not one of the choices."
        play_game(codeMaker)
      elsif code_choice == 'codemaker'
        codeMaker.human_secret_colors
        correct_computer_choices = ['incorrect', 'incorrect', 'incorrect', 'incorrect']
        correct_computer_color_choices = []
        correct_computer_color_choices_selector = []
        remaining_computer_choices = ['blue', 'yellow', 'red', 'green', 
                              'orange', 'purple']
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
            p correct_computer_color_choices_selector
            if correct_computer_color_choices_selector != []
              while correct_computer_color_choices_selector == [] do
                 computer_choice_index = rand(0..3)
                 if computer_choices[computer_choice_index] = 'incorrect'
                   correct_computer_color_choices_selector.sample(1).join = computer_choices[computer_choice_index]
                   correct_computer_color_choices_selector.delete(computer_choices[computer_choice_index])
                 end
              end
            end
            computer_choices.each_with_index do |color, index|
              if color == 'incorrect' && correct_computer_color_choices_selector != []
                 double_color_check = correct_computer_color_choices_selector.sample(1).join
                 if computer_choices.include?(double_color_check)
                   correct_computer_color_choices_selector.delete(double_color_check)
                   if correct_computer_color_choices_selector != []
                     computer_choices[index] = correct_computer_color_choices_selector.sample(1).join
                     double_color_check = remaining_computer_choices.sample(1).join
                     if computer_choices.include?(double_color_check)
                       computer_choices[index] = remaining_computer_choices.sample(1).join
                     else
                       computer_choices[index] = double_color_check
                     end
                   end
                 else
                   computer_choices[index] = double_color_check
                 end
              elsif color == 'incorrect'
                 double_color_check = remaining_computer_choices.sample(1).join
                 if computer_choices.include?(double_color_check)
                   computer_choices[index] = remaining_computer_choices.sample(1).join
                 else
                   computer_choices[index] = double_color_check
                 end
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
                p secret_color
                p computer_choices[index]
                p computer_choices
                if p computer_choices[index] == secret_color  
                correct_color += 1 
                  #unless correct_computer_color_choices.include?(secret_color)
                  #  correct_computer_color_choices.push(secret_color)
                  #end  
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
  
      else
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
  end
  
  board = Board.new
  coder = CodeMaker.new
  
  board.play_game(coder)