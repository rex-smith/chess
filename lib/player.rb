require_relative 'piece'
require_relative 'space'

class Player
  include Space
  def initialize(color, board)
    @board = board
    @pieces = {}
    @color = color
    initialize_pieces(color)
    @check_status  = false
    @possible_moves = []
  end

  attr_accessor :board, :possible_moves
  attr_reader :pieces, :color

  def initialize_pieces(color)
    if color == 'white'
      @pieces = 
      {
        pawn1: WhitePawn.new(self, 'a2', "\u265f", 'white'),
        pawn2: WhitePawn.new(self, 'b2', "\u265f", 'white'),
        pawn3: WhitePawn.new(self, 'c2', "\u265f", 'white'),
        pawn4: WhitePawn.new(self, 'd2', "\u265f", 'white'),
        pawn5: WhitePawn.new(self, 'e2', "\u265f", 'white'),
        pawn6: WhitePawn.new(self, 'f2', "\u265f", 'white'),
        pawn7: WhitePawn.new(self, 'g2', "\u265f", 'white'),
        pawn8: WhitePawn.new(self, 'h2', "\u265f", 'white'),
        rook1: Rook.new(self, 'a1', "\u265c", 'white'),
        rook2: Rook.new(self, 'h1', "\u265c", 'white'),
        knight1: Knight.new(self, 'g1', "\u265e", 'white'),
        knight2: Knight.new(self, 'b1', "\u265e", 'white'),
        bishop1: Bishop.new(self, 'c1', "\u265d", 'white'),
        bishop2: Bishop.new(self, 'f1', "\u265d", 'white'),
        queen: Queen.new(self, 'd1', "\u265b", 'white'),
        king: King.new(self, 'e1', "\u265a", 'white')
      }
    else
      @pieces = 
      {
      pawn1: BlackPawn.new(self, 'a7', "\u2659", 'black'),
      pawn2: BlackPawn.new(self, 'b7', "\u2659", 'black'),
      pawn3: BlackPawn.new(self, 'c7', "\u2659", 'black'),
      pawn4: BlackPawn.new(self, 'd7', "\u2659", 'black'),
      pawn5: BlackPawn.new(self, 'e7', "\u2659", 'black'),
      pawn6: BlackPawn.new(self, 'f7', "\u2659", 'black'),
      pawn7: BlackPawn.new(self, 'g7', "\u2659", 'black'),
      pawn8: BlackPawn.new(self, 'h7', "\u2659", 'black'),
      rook1: Rook.new(self, 'a8', "\u2656", 'black'),
      rook2: Rook.new(self, 'h8', "\u2656", 'black'),
      knight1: Knight.new(self, 'g8', "\u2658", 'black'),
      knight2: Knight.new(self, 'b8', "\u2658", 'black'),
      bishop1: Bishop.new(self, 'c8', "\u2657", 'black'),
      bishop2: Bishop.new(self, 'f8', "\u2657", 'black'),
      queen: Queen.new(self, 'd8', "\u2655", 'black'),
      king: King.new(self, 'e8', "\u2654", 'black')
      }
    end
  end

  def check?
    @board.active_enemy.possibleMoves
    @board.active_enemy.possible_moves.each do |move|
      if move.include?(@pieces[king].position)
        return true
      end
    end
    return false
  end

  def possibleMoves
    @possible_moves = []
    @pieces.each do |piece|
      piece.possible_moves.each do |move|
        @possible_moves.push(move)
      end
    end
  end

  def move
    loop do
      puts "#{@color}, please enter in a move (ex. a2-b5):"
      move = gets.chomp
      if move.length != 5
        continue
      end
      # Need to match the current location to a piece (Hash method)
      selected_piece = move[0..1]
      new_location = numberPosition(move[3..4])
      move = [selected_piece, new_location]
      if @possible_moves.include?(move)
        return move
      else
        continue
      end
      break
    end

    # Remove opponent's piece if move captures
    # Move piece to new spot on board and update board

  end

end
