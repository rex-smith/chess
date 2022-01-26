class Piece
  def initialize(position, symbol, color)
    @char_position = position
    @symbol = symbol
    @color = color
    @possible_moves = []
    @num_position = numberPosition(@char_position)
  end

  def numberPosition(position)
    column = position[0].ord - 97
    row = -1*(position[1].to_i-8)
    numbered = [row, column]
    return numbered
  end


  attr_reader :symbol, :char_position, :possible_moves, :num_position
  
end

class WhitePawn < Piece
  # Add initial move feature later
  # Add en passant later

  MOVES = [[0, 1], [-1, 1], [1, 1]].freeze

  def possibleMoves
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .reject_if {|location| occupied_self?(location) }
                 .keep_if {|location| location.valid? }
    return move_array
  end
end

class BlackPawn < Piece
  MOVES = [[0, -1], [-1, -1], [1, -1]].freeze

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

end
