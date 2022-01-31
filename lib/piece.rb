require_relative 'space'

class Piece
  include Space
  def initialize(player, position, symbol, color)
    @char_position = position
    @symbol = symbol
    @color = color
    @player = player
    @possible_moves = []
    @num_position = numberPosition(@char_position)
  end

  attr_reader :symbol, :char_position, :possible_moves, :num_position

  def test_move(move)
    test_board = @player.board
    test_board.grid[self.num_position[0]][self.num_position[1]] = ' '
    test_board.grid[position[0]][position[1]] = self
    @player.check?
  end

  # Map moves from array set
  
  # Reject if occupiedBySelf

  # Keep if onBoard

end

# Pawns -> King -> Knights
# Rooks -> Bishops -> Queen

class WhitePawn < Piece
  # Add initial move feature later
  # Add en passant later
  # Add Queening later

  # Think about how moves are actually going to be [row, column]
  # which is [y, x]
  MOVES = [[0, -1], [-1, -1], [1, -1]].freeze

  def possibleMoves
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .reject_if {|location| @player.board.occupied_self?(location) }
                 .keep_if {|location| @player.board.onBoard?(location) }
    move_array = move_array.select do |position|
      # Updated potential board with move
      @player.board.grid[num_position[0]][num_position[1]] = ' '
      @player.board.grid[position[0]][position[1]] = self
      # Check if this puts us in check
      # Need to figure out how to calculate check on fake board or 
      # use the real board and just reverse moves

      if @player.check?
        return false
      end
      return true
    end

    # Make move_array format [piece, move location]
    move_array = move_array.map do |move|
      [self, move]
    end
    return move_array
  end
end

class BlackPawn < Piece
  MOVES = [[1, 0], [1, -1], [1, 1]].freeze
  move_array = []
  def possibleMoves
    
  end
end

class Rook < Piece
  
end

class Knight < Piece
  MOVES = [[1, 2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

end

class Bishop < Piece
  
end

class Queen < Piece

end

class King < Piece
  MOVES = [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]].freeze

end
