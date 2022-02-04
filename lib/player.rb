require_relative 'piece'
require_relative 'space'

class Player
  include Space
  def initialize(color, board)
    @board = board
    @pieces = []
    @removed_piece = nil
    @last_move = nil
    @color = color
    @enemy = nil
    # initialize_pieces(color)
    @possible_moves_no_check = []
    @possible_moves_pre_check = []
  end

  MOVE_FORMAT = /[a-hA-H][0-7]\-[a-hA-H][0-7]/
  attr_accessor :board, :possible_moves_no_check, :pieces, :color, :possible_moves_pre_check,
                :enemy, :last_move, :removed_piece


  def initialize_pieces(color)
    if color == 'white'
      @pieces = 
      [
        WhitePawn.new(self, [0,6]),
        WhitePawn.new(self, [1,6]),
        WhitePawn.new(self, [2,6]),
        WhitePawn.new(self, [3,6]),
        WhitePawn.new(self, [4,6]),
        WhitePawn.new(self, [5,6]),
        WhitePawn.new(self, [6,6]),
        WhitePawn.new(self, [7,6]),
        Rook.new(self, [0,7]),
        Rook.new(self, [7,7]),
        Knight.new(self, [1,7]),
        Knight.new(self, [6,7]),
        Bishop.new(self, [2,7]),
        Bishop.new(self, [5,7]),
        Queen.new(self, [3,7]),
        King.new(self, [4,7])
      ]
    else
      @pieces = 
      [
      BlackPawn.new(self, [0,1]),
      BlackPawn.new(self, [1,1]),
      BlackPawn.new(self, [2,1]),
      BlackPawn.new(self, [3,1]),
      BlackPawn.new(self, [4,1]),
      BlackPawn.new(self, [5,1]),
      BlackPawn.new(self, [6,1]),
      BlackPawn.new(self, [7,1]),
      Rook.new(self, [0,0]),
      Rook.new(self, [7,0]),
      Knight.new(self, [1,0]),
      Knight.new(self, [6,0]),
      Bishop.new(self, [2,0]),
      Bishop.new(self, [5,0]),
      Queen.new(self, [3,0]),
      King.new(self, [4,0])
      ]
    end
  end

  def check?
    # Check if enemy's possible moves pre check can hit king
    king = @pieces.find {|piece| piece.instance_of? King }
    king_position = king.num_position
    enemy_moves = @enemy.total_moves_pre_check
    enemy_moves.each do |move|
      if move == king_position
        return true
      end
    end
    return false
  end

  def total_moves_no_check
    @possible_moves_no_check = []
    @pieces.each do |piece|
      piece.moves_no_check.each do |move|
        @possible_moves_no_check.push(move)
      end
    end
    @possible_moves_no_check
  end

  def total_moves_pre_check
    @possible_moves_pre_check = []
    @pieces.each do |piece|
      piece.moves_pre_check.each do |move|
        @possible_moves_pre_check.push(move)
      end
    end
    @possible_moves_pre_check
  end

  def choose_move
    move = []
    valid_move = false
    until valid_move == true
      # Loop through until the move is verified as valid
      puts "#{@color}, please enter in a move (ex. a2-b5):"
      move = gets.chomp
      if !move.match?(MOVE_FORMAT)
        continue
      end

      # Match the current location to a piece
      start_loc = numberPosition(move[0..1])
      selected_piece = @board.select_piece(start_loc)
      new_location = numberPosition(move[3..4])

      # This could be a method
      if selected_piece.moves_no_check.include?(new_location)
        move = [selected_piece.num_location, new_location]
        valid_move = true
      end
    end
    return move
  end

  def play_turn
    # Loop through until player chooses valid move
    move = choose_move
    # Capture opponent if they occupied the space
    capture_opponent(move[1])
    # Move our piece to the new location
    move_piece(move[0], move[1])
  end

  def capture_opponent(position)
    # Remove opponent's piece if move captures
    if occupied_enemy?(position)
      piece_to_remove = @board.select_piece(position)
      @enemy.removed_piece = piece_to_remove
      @enemy.pieces.delete_if {|piece| piece == piece_to_remove}
    end
  end

  def reverse_capture
    # Reverse the capturing of a piece
    if !@enemy.removed_piece.nil?
      @enemy.pieces << @enemy.removed_piece
      @enemy.removed_piece = nil
    end
  end

  def move_piece(start_location, end_location)
    # Move piece to new spot on board and update board
    selected_piece = @board.select_piece(start_location)
    # Set selected piece's location to the end location
    selected_piece.num_position = end_location
    @last_move = [start_location, end_location]
    @board.updateBoard
  end

  def occupied_self?(position)
    if @board.contains_piece?(position)
      if @board.grid[position[1]][position[0]].color == @color
        return true
      end
    end
    return false
  end

  def occupied_enemy?(position)
    if @board.contains_piece?(position)
      if @board.grid[position[1]][position[0]].color == @enemy.color
        return true
      end
    end
    return false
  end

end
