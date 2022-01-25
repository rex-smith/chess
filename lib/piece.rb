class Piece
  def initialize(position, symbol)
    @position = position
    @symbol = symbol
  end

  attr_reader :symbol, :position
  
end

class Pawn < Piece

end

class Rook < Piece

end

class Knight < Piece

end

class Bishop < Piece
  
end

class Queen < Piece

end

class King < Piece

end
