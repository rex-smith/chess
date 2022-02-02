require_relative 'space'

class Piece
  include Space
  def initialize(player, position, symbol, color)
    @symbol = symbol
    @color = color
    @player = player
    @possible_moves = []
    @num_position = position
    @char_position = charPosition(@num_position)
  end

  attr_reader :symbol, :char_position, :possible_moves, :num_position, :color

end

class WhitePawn < Piece

  ATTACK_MOVES = [[-1, -1], [1, -1]].freeze
  STRAIGHT_MOVE = [[0,-1]].freeze

  def moves_pre_check
    move_array = []
    move_array = STRAIGHT_MOVE.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.board.occupied_self?(location) }
                 .reject {|location| @player.board.occupied_enemy?(location) }

    move_array << ATTACK_MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .keep_if {|location| @player.board.occupied_enemy?(location) }


    # Make move_array format [piece, move location]
    move_array = move_array.map do |move|
      [self, move]
    end
    return move_array
  end

  def moves_no_check
    move_array = []
    move_array = moves_pre_check
    move_array = move_array.select do |move|
      in_check = false
      # Run through full move scenario
      @player.capture_opponent(move[1])
      @player.move_piece(move)
      in_check = @player.check?
      # Reverse move back to original
      @player.move_piece(@player.last_move)
      @player.reverse_capture(@player.removed_pieces.last)
      # Only select moves that don't move into check
      return !in_check
    end
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
