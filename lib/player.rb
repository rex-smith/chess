require_relative 'piece'

class Player
  def initialize(color)
    @pieces = []
    @color = color
    initialize_pieces(color)
  end

  attr_reader :pieces

  def initialize_pieces(color)
    if color == 'white'
      @pieces = 
      [
        @pawn1 = Pawn.new('a2', "\u2659"),
        @pawn2 = Pawn.new('b2', "\u2659"),
        @pawn3 = Pawn.new('c2', "\u2659"),
        @pawn4 = Pawn.new('d2', "\u2659"),
        @pawn5 = Pawn.new('e2', "\u2659"),
        @pawn6 = Pawn.new('f2', "\u2659"),
        @pawn7 = Pawn.new('g2', "\u2659"),
        @pawn8 = Pawn.new('h2', "\u2659"),
        @rook1 = Rook.new('a1', "\u2656"),
        @rook2 = Rook.new('h1', "\u2656"),
        @knight1 = Knight.new('g1', "\u2658"),
        @knight2 = Knight.new('b1', "\u2658"),
        @bishop1 = Bishop.new('c1', "\u2657"),
        @bishop2 = Bishop.new('f1', "\u2657"),
        @queen = Queen.new('d1', "\u2655"),
        @king = King.new('e1', "\u2654")
      ]
    else
      @pieces = 
      [
      @pawn1 = Pawn.new('a7', "\u265f"),
      @pawn2 = Pawn.new('b7', "\u265f"),
      @pawn3 = Pawn.new('c7', "\u265f"),
      @pawn4 = Pawn.new('d7', "\u265f"),
      @pawn5 = Pawn.new('e7', "\u265f"),
      @pawn6 = Pawn.new('f7', "\u265f"),
      @pawn7 = Pawn.new('g7', "\u265f"),
      @pawn8 = Pawn.new('h7', "\u265f"),
      @rook1 = Rook.new('a8', "\u265c"),
      @rook2 = Rook.new('h8', "\u265c"),
      @knight1 = Knight.new('g8', "\u265e"),
      @knight2 = Knight.new('b8', "\u265e"),
      @bishop1 = Bishop.new('c8', "\u265d"),
      @bishop2 = Bishop.new('f8', "\u265d"),
      @queen = Queen.new('d8', "\u265b"),
      @king = King.new('e8', "\u265a")
    ]
    end
  end
end
