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
        pawn1: WhitePawn.new('a2', "\u265f", 'white'),
        pawn2: WhitePawn.new('b2', "\u265f", 'white'),
        pawn3: WhitePawn.new('c2', "\u265f", 'white'),
        pawn4: WhitePawn.new('d2', "\u265f", 'white'),
        pawn5: WhitePawn.new('e2', "\u265f", 'white'),
        pawn6: WhitePawn.new('f2', "\u265f", 'white'),
        pawn7: WhitePawn.new('g2', "\u265f", 'white'),
        pawn8: WhitePawn.new('h2', "\u265f", 'white'),
        rook1: Rook.new('a1', "\u265c", 'white'),
        rook2: Rook.new('h1', "\u265c", 'white'),
        knight1: Knight.new('g1', "\u265e", 'white'),
        knight2: Knight.new('b1', "\u265e", 'white'),
        bishop1: Bishop.new('c1', "\u265d", 'white'),
        bishop2: Bishop.new('f1', "\u265d", 'white'),
        queen: Queen.new('d1', "\u265b", 'white'),
        king: King.new('e1', "\u265a", 'white')
      }
    else
      @pieces = 
      {
      pawn1: BlackPawn.new('a7', "\u2659", 'black'),
      pawn2: BlackPawn.new('b7', "\u2659", 'black'),
      pawn3: BlackPawn.new('c7', "\u2659", 'black'),
      pawn4: BlackPawn.new('d7', "\u2659", 'black'),
      pawn5: BlackPawn.new('e7', "\u2659", 'black'),
      pawn6: BlackPawn.new('f7', "\u2659", 'black'),
      pawn7: BlackPawn.new('g7', "\u2659", 'black'),
      pawn8: BlackPawn.new('h7', "\u2659", 'black'),
      rook1: Rook.new('a8', "\u2656", 'black'),
      rook2: Rook.new('h8', "\u2656", 'black'),
      knight1: Knight.new('g8', "\u2658", 'black'),
      knight2: Knight.new('b8', "\u2658", 'black'),
      bishop1: Bishop.new('c8', "\u2657", 'black'),
      bishop2: Bishop.new('f8', "\u2657", 'black'),
      queen: Queen.new('d8', "\u2655", 'black'),
      king: King.new('e8', "\u2654", 'black')
      }
    end
  end

  # def possibleMoves
  #   @possible_moves = []
  #   @pieces.each do |piece|
  #     @possible_moves.push(piece.possibleMoves)
    
  # end
end
