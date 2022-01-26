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

  def capture(piece)
    piece.remove
  end

  def remove
    self.delete
    # CHECK RUBY SYNTAX FOR DELETING
    # Probably just needs to be deleted from the player's pieces hash

  end


  attr_reader :symbol, :char_position, :possible_moves, :num_position
  
end

# Pawns -> King -> Knights
# Rooks -> Bishops -> Queen

class WhitePawn < Piece
  # Add initial move feature later
  # Add en passant later
  # Add Queening later

  # Think about how moves are actually going to be [row, column]
  # which is [y, x]

  MOVES = [[-1, 0], [-1, 1], [-1, -1]].freeze

  def possibleMoves
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .reject_if {|location| self.player.board.occupied_self?(location) }
                 .keep_if {|location| self.player.board.onBoard?(location) }
    move_array = move_array.select do |position|
      # Updated potential board with move
      @player.board.potential_board[num_position[0]][num_position[1]] = ' '
      @player.board.potential_board[position[0]][position[1]] = self
      # Check if this puts us in check
      # Need to figure out how to calculate check on fake board or 
      # use the real board and just reverse moves
      if @player.check?
        return false
      end
      return true
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
