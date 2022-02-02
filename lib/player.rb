require_relative 'piece'
require_relative 'space'

class Player
  include Space
  def initialize(color, board)
    @board = board
    @pieces = []
    @removed_pieces = []
    @last_move = nil
    @color = color
    @enemy = nil
    initialize_pieces(color)
    @possible_moves_no_check = []
    @possible_moves_pre_check = []
  end

  attr_accessor :board, :possible_moves_no_check, :pieces, :color, :possible_moves_pre_check

  def initialize_pieces(color)
    if color == 'white'
      @pieces = 
      [
        WhitePawn.new(self, 'a2', "\u265f", 'white'),
        WhitePawn.new(self, 'b2', "\u265f", 'white'),
        WhitePawn.new(self, 'c2', "\u265f", 'white'),
        WhitePawn.new(self, 'd2', "\u265f", 'white'),
        WhitePawn.new(self, 'e2', "\u265f", 'white'),
        WhitePawn.new(self, 'f2', "\u265f", 'white'),
        WhitePawn.new(self, 'g2', "\u265f", 'white'),
        WhitePawn.new(self, 'h2', "\u265f", 'white'),
        Rook.new(self, 'a1', "\u265c", 'white'),
        Rook.new(self, 'h1', "\u265c", 'white'),
        Knight.new(self, 'g1', "\u265e", 'white'),
        Knight.new(self, 'b1', "\u265e", 'white'),
        Bishop.new(self, 'c1', "\u265d", 'white'),
        Bishop.new(self, 'f1', "\u265d", 'white'),
        Queen.new(self, 'd1', "\u265b", 'white'),
        King.new(self, 'e1', "\u265a", 'white')
      ]
      @enemy = @board.black
    else
      @pieces = 
      [
      BlackPawn.new(self, 'a7', "\u2659", 'black'),
      BlackPawn.new(self, 'b7', "\u2659", 'black'),
      BlackPawn.new(self, 'c7', "\u2659", 'black'),
      BlackPawn.new(self, 'd7', "\u2659", 'black'),
      BlackPawn.new(self, 'e7', "\u2659", 'black'),
      BlackPawn.new(self, 'f7', "\u2659", 'black'),
      BlackPawn.new(self, 'g7', "\u2659", 'black'),
      BlackPawn.new(self, 'h7', "\u2659", 'black'),
      Rook.new(self, 'a8', "\u2656", 'black'),
      Rook.new(self, 'h8', "\u2656", 'black'),
      Knight.new(self, 'g8', "\u2658", 'black'),
      Knight.new(self, 'b8', "\u2658", 'black'),
      Bishop.new(self, 'c8', "\u2657", 'black'),
      Bishop.new(self, 'f8', "\u2657", 'black'),
      Queen.new(self, 'd8', "\u2655", 'black'),
      King.new(self, 'e8', "\u2654", 'black')
      ]
      @enemy = @board.white
    end
  end

  def check?
    # Check if enemy's possible moves pre check can hit king
    enemy_moves = @enemy.total_moves_pre_check
    enemy_moves.each do |move|
      if move[1].include?(@pieces[king].position)
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
    until @possible_moves_no_check.include?(move)
      # Loop through until the move is verified as valid
      puts "#{@color}, please enter in a move (ex. a2-b5):"
      move = gets.chomp
      if move.length != 5
        continue
      end

      # Match the current location to a piece
      start_loc = numberPosition(move[0..1])
      selected_piece = select_piece(start_loc)
      new_location = numberPosition(move[3..4])
      move = [selected_piece, new_location]
    end
    return move
  end

  def play_turn
    # Outline possible moves
    possibleMoves
    # Loop through until player chooses valid move
    move = choose_move
    # Capture opponent if they occupied the space
    capture_opponent(move)
    # Move our piece to the new location
    move_piece(move)
  end

  def capture_opponent(position)
    # Remove opponent's piece if move captures
    @enemy.pieces.each do |piece|
      if piece.num_position == position
        # Add to removed hash in case we need to add back
        @enemy.removed_pieces << piece
        # Delete from array
        @enemy.pieces.delete(piece)
      end
    end
  end

  def reverse_capture(piece)
    # Reverse the capturing of a piece
    @enemy.pieces << piece
  end

  def move_piece(move)
    # Move piece to new spot on board and update board
    move[0].num_position = move[1]
    board.updateBoard
  end

  def select_piece(num_location)
    # This may return a hash, needs to be checked
    selected_piece = @pieces.select do |piece|
      if piece.num_position == num_location
        return true
      else
        return false
      end
    end
    return selected_piece
  end
end
