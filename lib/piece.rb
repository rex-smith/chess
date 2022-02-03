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
    @player.pieces << self
  end

  attr_reader :symbol, :char_position, :possible_moves, :color
  attr_accessor :num_position

  def moves_no_check
    move_array = []
    move_array = moves_pre_check
    no_check_moves = []
    move_array.each do |move|
      # Run through full move scenario
      @player.capture_opponent(move)
      @player.move_piece(@num_position, move)
      if !@player.check?
        no_check_moves << move
      end
      # Reverse move back to original
      @player.move_piece(@player.last_move[1], @player.last_move[0])
      @player.reverse_capture
    end

    return no_check_moves
  end

  # For Bishops, Queens, Rooks:
  # Have four arrays of moves (6 for queen) (diag-left, diag-right, diag-back-left, diag-back-right)
  # look through until blocked or off board, then cancel rest
  # Use these as the initial map array

  def move_search(transformation)
    start_point = @num_position
    last_captured = false
    move_array = []
    # First move or transformation
    location = [start_point[0] + transformation[0], start_point[1] + transformation[1]]
    # Stopping requirements (off board, occupied by self or last space was blocked by enemy)
    until !@player.board.onBoard?(location) || @player.occupied_self?(location) || last_captured == true
      move_array << location
      last_captured = true if @player.occupied_enemy?(location) == true
      location = [location[0] + transformation[0], location[1] + transformation[1]]
    end
    return move_array
  end

end

class WhitePawn < Piece

  ATTACK_MOVES = [[-1, -1], [1, -1]].freeze
  STRAIGHT_MOVE = [[0,-1]].freeze

  def moves_pre_check
    move_array = []
    attack_move_array = []
    move_array = STRAIGHT_MOVE.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.occupied_self?(location) }
                 .reject {|location| @player.occupied_enemy?(location) }

    attack_move_array = ATTACK_MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .keep_if {|location| @player.occupied_enemy?(location) }

    unless attack_move_array.empty?
      move_array = move_array + attack_move_array
    end
    return move_array
  end

end

class BlackPawn < Piece
  
  ATTACK_MOVES = [[-1, 1], [1, 1]].freeze
  STRAIGHT_MOVE = [[0, 1]].freeze

  def moves_pre_check
    move_array = []
    attack_move_array = []
    move_array = STRAIGHT_MOVE.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.occupied_self?(location) }
                 .reject {|location| @player.occupied_enemy?(location) }

    attack_move_array = ATTACK_MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .keep_if {|location| @player.occupied_enemy?(location) }

    unless attack_move_array.empty?
      move_array = move_array + attack_move_array
    end
    return move_array
  end

end

class Rook < Piece
  TRANSFORMATIONS = [[0,1], [0,-1], [-1,0], [1,0]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class Knight < Piece
  MOVES = [[1, 2], [-2, -1], [-1, 2], [2, -1], [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  def moves_pre_check
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.occupied_self?(location) }
    return move_array
  end
end

class Bishop < Piece
  TRANSFORMATIONS = [[1,1], [1,-1], [-1,1], [-1,-1]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class Queen < Piece
  TRANSFORMATIONS = [[1,1], [1,-1], [-1,1], [-1,-1], [0,1], [1,0], [0, -1], [-1, 0]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class King < Piece
  MOVES = [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]].freeze

  def moves_pre_check
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.occupied_self?(location) }
    return move_array
  end
end
