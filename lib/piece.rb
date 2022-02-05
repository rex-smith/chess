require_relative 'space'
require 'json'

class Piece
  include Space
  def initialize(player, position, moves=0)
    @color = player.color
    @player = player
    @possible_moves = []
    @num_position = position
    @char_position = charPosition(@num_position)
    @player.pieces << self
    @moves = moves
  end

  attr_reader :symbol, :char_position, :possible_moves, :color
  attr_accessor :num_position, :moves

  def moves_no_check
    move_array = []
    move_array = moves_pre_check
    no_check_moves = []

    move_array.each do |end_position|
      # Run through full move scenario
      start_position = @num_position

      need_to_reverse = false
      # Run through move scenario
      if @player.occupied_enemy?(end_position)
        need_to_reverse = true
      end
      @player.capture_opponent(end_position)
      @player.move_piece(start_position, end_position)

      # If in check, add to list so can notify user
      # If not in check, add to list of possible moves
      if !@player.check?
        no_check_moves << end_position
      end

      # Reverse move back to original
      @player.move_piece(end_position, start_position)

      if need_to_reverse == true
        @player.reverse_capture
      end
      
    end

    return no_check_moves
  end

  def check_moves
    moves = moves_pre_check - moves_no_check
    return moves
  end

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

  def initialize(player, position)
    super(player, position)
    @symbol = "\u265f"
  end

  ATTACK_MOVES = [[-1, -1], [1, -1]].freeze
  STRAIGHT_MOVE = [[0,-1]].freeze

  def moves_pre_check
    move_array = []
    attack_move_array = []

    if @moves == 0
      pawn_moves = STRAIGHT_MOVE + [[0,-2]]
    else
      pawn_moves = STRAIGHT_MOVE
    end

    move_array = pawn_moves.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
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
  def initialize(player, position)
    super(player, position)
    @symbol = "\u2659"
  end
  
  ATTACK_MOVES = [[-1, 1], [1, 1]].freeze
  STRAIGHT_MOVE = [[0, 1]].freeze

  def moves_pre_check
    move_array = []
    attack_move_array = []

    if @moves == 0
      pawn_moves = STRAIGHT_MOVE + [[0,2]]
    else
      pawn_moves = STRAIGHT_MOVE
    end

    move_array = pawn_moves.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
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
  def initialize(player, position)
    super(player, position)
    @symbol = @color == 'white' ? "\u265c" : "\u2656"
  end

  TRANSFORMATIONS = [[0,1], [0,-1], [-1,0], [1,0]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class Knight < Piece
  def initialize(player, position)
    super(player, position)
    @symbol = @color == 'white' ? "\u265e" : "\u2658"
  end
  
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
  def initialize(player, position)
    super(player, position)
    @symbol = @color == 'white' ? "\u265d" : "\u2657"
  end
  
  TRANSFORMATIONS = [[1,1], [1,-1], [-1,1], [-1,-1]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class Queen < Piece
  def initialize(player, position)
    super(player, position)
    @symbol = @color == 'white' ? "\u265b" : "\u2655"
  end
  
  TRANSFORMATIONS = [[1,1], [1,-1], [-1,1], [-1,-1], [0,1], [1,0], [0, -1], [-1, 0]].freeze

  def moves_pre_check
    move_array = []
    move_array = TRANSFORMATIONS.map { |transformation| move_search(transformation) }.flatten(1)
    return move_array
  end
end

class King < Piece
  def initialize(player, position)
    super(player, position)
    @symbol = @color == 'white' ? "\u265a" : "\u2654"
  end
  
  MOVES = [[1,0], [1,1], [0,1], [-1,1], [-1,0], [-1,-1], [0,-1], [1,-1]].freeze

  def moves_pre_check
    move_array = []
    move_array = MOVES.map {|move| [@num_position[0] + move[0], @num_position[1] + move[1]] }
                 .keep_if {|location| @player.board.onBoard?(location) }
                 .reject {|location| @player.occupied_self?(location) }
    return move_array
  end
end
