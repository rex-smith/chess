require_relative 'piece'

class Player
  def initialize(color)
    @pieces = {}
    @color = color
    initialize_pieces(color)
    @check_status  = false
  end

  attr_reader :pieces, :color

  def initialize_pieces(color)
    if color == 'white'
      @pieces = 
      {
        pawn1: WhitePawn.new('a2', "\u2659", 'white'),
        pawn2: WhitePawn.new('b2', "\u2659", 'white'),
        pawn3: WhitePawn.new('c2', "\u2659", 'white'),
        pawn4: WhitePawn.new('d2', "\u2659", 'white'),
        pawn5: WhitePawn.new('e2', "\u2659", 'white'),
        pawn6: WhitePawn.new('f2', "\u2659", 'white'),
        pawn7: WhitePawn.new('g2', "\u2659", 'white'),
        pawn8: WhitePawn.new('h2', "\u2659", 'white'),
        rook1: Rook.new('a1', "\u2656", 'white'),
        rook2: Rook.new('h1', "\u2656", 'white'),
        knight1: Knight.new('g1', "\u2658", 'white'),
        knight2: Knight.new('b1', "\u2658", 'white'),
        bishop1: Bishop.new('c1', "\u2657", 'white'),
        bishop2: Bishop.new('f1', "\u2657", 'white'),
        queen: Queen.new('d1', "\u2655", 'white'),
        king: King.new('e1', "\u2654", 'white')
      }
    else
      @pieces = 
      {
      pawn1: BlackPawn.new('a7', "\u265f", 'black'),
      pawn2: BlackPawn.new('b7', "\u265f", 'black'),
      pawn3: BlackPawn.new('c7', "\u265f", 'black'),
      pawn4: BlackPawn.new('d7', "\u265f", 'black'),
      pawn5: BlackPawn.new('e7', "\u265f", 'black'),
      pawn6: BlackPawn.new('f7', "\u265f", 'black'),
      pawn7: BlackPawn.new('g7', "\u265f", 'black'),
      pawn8: BlackPawn.new('h7', "\u265f", 'black'),
      rook1: Rook.new('a8', "\u265c", 'black'),
      rook2: Rook.new('h8', "\u265c", 'black'),
      knight1: Knight.new('g8', "\u265e", 'black'),
      knight2: Knight.new('b8', "\u265e", 'black'),
      bishop1: Bishop.new('c8', "\u265d", 'black'),
      bishop2: Bishop.new('f8', "\u265d", 'black'),
      queen: Queen.new('d8', "\u265b", 'black'),
      king: King.new('e8', "\u265a", 'black')
      }
    end
  end

  # def possibleMoves
  #   @possible_moves = []
  #   @pieces.each do |piece|
  #     @possible_moves.push(piece.possibleMoves)
    
  # end
end
