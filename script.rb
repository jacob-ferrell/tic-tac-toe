#create an object for each player containing their name and their sign. $player1 is 'X' and $player2 is 'O' by default
class Player
  attr_accessor :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end
end
#create new player objects with player names and sign, and tell them which sign they have been assigned
def get_players
  puts 'Enter name of Player 1: '
  $player1 = Player.new(gets.chomp, 'X')
  puts 'Enter name of Player 2:'
  $player2 = Player.new(gets.chomp, 'O')
  print_line
  puts "#{$player1.name}, your sign is: #{$player1.sign}\n#{$player2.name}, your sign is: #{$player2.sign}"
  print_line
end
#method for printing a line to the screen, with optional argument for length
def print_line(n=60)
  puts '-' * n
end
#method for inserting n number of spaces, for centering things in the terminal
def spacer(n=25)
    ' ' * n
end

class Board
    attr_accessor :board

    def initialize
        @board = [(1..3).to_a, (4..6).to_a, (7..9).to_a]
    end

    def display_board
        print_line
        puts "#{spacer}#{@board[0]}\n#{spacer}#{@board[1]}\n#{spacer}#{@board[2]}" 
        print_line
    end

    def set_move(choice, sign)
        if valid_input?(choice)
            coord = get_coord(choice)
        else
            return invalid_input
            
            
        end
        if @board[coord[0]][coord[1]] == 'X' || @board[coord[0]][coord[1]] == 'O'
            return space_taken
            
        else
            @board[coord[0]][coord[1]] = sign
            return
        end

    end

    def valid_input?(choice)
        (1..9).to_a.include?(choice)
    end

    def space_taken
        puts "That space is not available. Please choose another"
        set_move(gets.chomp.to_i)
    end

    def get_coord(choice)
        if choice < 4
            [0, choice - 1]
        elsif choice < 7
            [1, choice - 4]
        else
            [2, choice - 7]
        end
    end

    def invalid_input
        puts "Invalid input.  Please enter a number between 1-9"
        set_move(gets.chomp.to_i)
        
    end
end

def game_over?
    false
end
new_board = Board.new
new_board.display_board
get_players

while !game_over? do 
    new_board.display_board
    puts "#{$player1.name}, choose your space by entering the corresponding number:"
    new_board.set_move(gets.chomp.to_i, 'X')
    new_board.display_board
    puts "#{$player2.name}, choose your space by entering the corresponding number:"
    new_board.set_move(gets.chomp.to_i, 'O')
    
    
end
