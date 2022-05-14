#create an object for each player containing their name and their sign. $player1 is 'X' and $player2 is 'O' by default
class Player
    attr_accessor :name, :sign
    
    
    @@num_players = 0
    def initialize
      @@num_players += 1  
      puts "Enter name of Player #{@@num_players}:"
      @name = gets.chomp
      @sign = @@num_players == 1 ? 'X' : 'O'
    end

    def get_choice
        puts "#{@name}, choose your space by entering the corresponding number:"
        choice = gets.chomp.to_i
        return is_valid?(choice) ? choice : invalid_input

    end

    def is_valid?(choice)
        (1..9).to_a.include?(choice)
    end

    def invalid_input
        puts "Invalid input.  Please enter a number between 1-9"
        get_choice
    end
end

class Board
    attr_accessor :board

    def initialize
        @board = [(1..3).to_a, (4..6).to_a, (7..9).to_a]
        
    end

    def print_line(n=60)
        puts '-' * n
    end

    def display
        spacer = ' ' * 25
        print_line
        puts "#{spacer}#{@board[0]}\n#{spacer}#{@board[1]}\n#{spacer}#{@board[2]}" 
        print_line
    end

    def change_board(choice, sign)
        coord = choice_to_coordinate(choice)
        @board[coord[0]][coord[1]] = sign
    end

    def choice_to_coordinate(choice)
        if choice < 4
            [0, choice - 1]
        elsif choice < 7
            [1, choice - 4]
        else
            [2, choice - 7]
        end
    end

end

class PlayGame
    attr_accessor :board

    def initialize
        @player1 = Player.new
        @player2 = Player.new
        @board = Board.new
        display_player_info
    end

    def display_player_info
        @board.print_line
        puts "#{@player1.name}, your sign is: #{@player1.sign}\n#{@player2.name}, your sign is: #{@player2.sign}"
        @board.display
        play_round
    end

    def print_line(n=60)
        puts '-' * n
    end

    def play_round
        @board.change_board(@player1.get_choice, @player1.sign)
        @board.display
        @board.change_board(@player2.get_choice, @player2.sign)
        @board.display

    end

    

end
PlayGame.new