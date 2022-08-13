class CodeMaker
    attr_accessor :secret_colors
  
    def initialize
      @secret_colors = %w[blue yellow red green orange purple].sample(4)
    end
  
    def human_secret_colors
      @secret_colors = []
      4.times do |index|
        puts "What color do you want to choose for peg #{index + 1}?"
        peg_choice = gets.chomp.downcase
        @secret_colors.push(peg_choice)
      end
    end
  end
  
  class Board
    attr_accessor :game
    def initialize
      @game = ''
    end
  
    def play_game(codeMaker)
      puts 'Would you like to be the codebreaker or the codemaker?'
      code_choice = gets.chomp.downcase
      if code_choice != 'codemaker' && code_choice != 'codebreaker'
        puts "That's not one of the choices."
        play_game(codeMaker)
      elsif code_choice == 'codemaker'
        codeMaker.human_secret_colors
        correct_computer_choices = ['incorrect', 'incorrect', 'incorrect', 'incorrect']
        remaining_computer_choices = ['blue', 'yellow', 'red', 'green', 
                              'orange', 'purple']
        12.times do
          correct_color_space = 0
          correct_color = 0
          break if @game == 'won'
          p codeMaker.secret_colors
          if correct_computer_choices == ['incorrect', 'incorrect', 'incorrect', 'incorrect']
             p computer_choices = %w[blue yellow red green orange purple].sample(4)
             p correct_computer_choices
          
          else 
            computer_choices = correct_computer_choices
            computer_choices.each_with_index do |color, index|
              if color == 'incorrect'
                 computer_choices[index] = remaining_computer_choices.sample(1).join
              end
            end
            p computer_choices
          end
            
          codeMaker.secret_colors.each_with_index do |secret_color, index|
            if secret_color == computer_choices[index]
              correct_color_space += 1
              correct_computer_choices[index] = secret_color
              remaining_computer_choices.delete(secret_color)
            elsif secret_color != computer_choices[index]
              correct_computer_choices[index] = 'incorrect'
            else
              codeMaker.secret_colors.each do |secret_color|
                if computer_choices[index] == secret_color  
                correct_color += 1 
                end
              end
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
  