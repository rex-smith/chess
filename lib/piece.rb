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

  def put_in_check(move)
    # Initialize the test grid as current state of grid
    @player.board.update_board(@player.board.test_grid)
    # Play move as if it is real
    # Capture opponent if there
    @player.capture_opponent(move, @player.board.test_grid)
    # Move our piece to the new location
    @player.move_piece(move, @player.board.test_grid)
    # Update the test grid
    @player.board.update_board(@player.board.test_grid)
    # See if we are now in check
    in_check = @player.check?(@player.board.test_grid)
    return !in_check
  end

end

class WhitePawn < Piece
  # Add initial move feature later
  # Add en passant later
  # Add Queening later

  MOVES = [[0, -1], [-1, -1], [1, -1]].freeze

  def possible_moves_pre_check
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .reject_if {|location| @player.board.occupied_self?(location) }
                 .keep_if {|location| @player.board.onBoard?(location) }
    # Make move_array format [piece, move location]
    move_array = move_array.map do |move|
      [self, move]
    end
    return move_array
  end

  def possible_moves_no_check
    move_array = []
    move_array = possible_moves_pre_check
    move_array = move_array.select {|move| put_in_check(move)}
    return move_array
  end
end

class BlackPawn < Piece
  MOVES = [[1, 0], [1, -1], [1, 1]].freeze
  
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
