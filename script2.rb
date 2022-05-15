#create an object for each player containing their name and their sign. $player1 is 'X' and $player2 is 'O' by default
class Player
    attr_accessor :name, :sign, :spaces_taken
    
    
    @@num_players = 0
    def initialize(board)
      @@board = board
      @@num_players += 1  
      puts "Enter name of Player #{@@num_players}:"
      @name = gets.chomp
      @sign = @@num_players == 1 ? 'X' : 'O'
      @spaces_taken = []
    end

    def get_choice
        puts "#{@name}, choose your space by entering the corresponding number:"
        choice = gets.chomp.to_i
        if is_valid?(choice)
            if !space_available?(choice)
                 unavailable_space
            end
            @spaces_taken.push(choice)
            choice
        else
            invalid_input
        end
        

    end

    def is_valid?(choice)
        (1..9).to_a.include?(choice)
    end

    def space_available?(choice)
        coord = @@board.choice_to_coordinate(choice)
        @@board.board[coord[0]][coord[1]].instance_of? Integer
    end

    def unavailable_space
        @@board.print_line
        puts "That space is taken. Please choose an available space"
        @@board.print_line
        get_choice
    end

    def invalid_input
        @@board.print_line
        puts "Invalid input.  Please enter a number between 1-9"
        @@board.print_line
        get_choice
    end
end

class Board
    attr_reader :board, :available_spaces

    @@available_spaces = 9

    def initialize
        @board = [(1..3).to_a, (4..6).to_a, (7..9).to_a]
        
    end

    def print_line(n=60)
        puts '-' * n
    end

    def spacer(n=17)
        ' ' * n
    end

    def display
        print_line
        puts "#{spacer}|#{@board[0][0]}#{spacer(5)}#{@board[0][1]}#{spacer(5)}#{@board[0][2]}|"
        puts "#{spacer}|#{@board[1][0]}#{spacer(5)}#{@board[1][1]}#{spacer(5)}#{@board[1][2]}|"
        puts "#{spacer}|#{@board[2][0]}#{spacer(5)}#{@board[2][1]}#{spacer(5)}#{@board[2][2]}|"
        print_line
    end

    def change_board(choice, sign)
        coord = choice_to_coordinate(choice)
        @board[coord[0]][coord[1]] = sign
        @@available_spaces -= 1
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

    def get_available_spaces
        @@available_spaces
    end
end

class PlayGame
    attr_accessor :board

    WINNING_SPACES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

    def initialize
        @board = Board.new
        @player1 = Player.new(@board)
        @player2 = Player.new(@board)
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
        while !game_over? do
            @board.change_board(@player1.get_choice, @player1.sign)
            @board.display
          if game_over?  
            break
          end  
            @board.change_board(@player2.get_choice, @player2.sign)
            @board.display
        end    
    end

    def game_over?
       if WINNING_SPACES.select{ |combo| (combo - @player1.spaces_taken).empty? }.any?
        set_winner(@player1.name)
        return true
       elsif  WINNING_SPACES.select{ |combo| (combo - @player2.spaces_taken).empty? }.any?
        set_winner(@player2.name)
        return true
       elsif @board.get_available_spaces < 1
        puts "It's a tie!  No one wins..."
        return true
       else
        return false
       end   
    end

    def set_winner(winner)
        puts "Game Over!  #{winner} wins!"
    end

    

end
PlayGame.new