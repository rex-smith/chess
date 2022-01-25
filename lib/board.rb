require_relative '/player'

class Board
  def initialize
    @board = Array.new(8) {Array.new(8) {' '}}
    @white = Player.new('white')
    @black = PLayer.new('black')
    @active_player = @white
  end

  def displayBoard
    @board.reverse_each do |row|
      row.each do |symbol|
        p "[#{space}]"
      end
      p "\n"
    end
  end

  def updateBoard
    @board = Array.new(8) {Array.new(8) {' '}}

    for piece in @white.pieces
      piece_position = piece.position
      column = piece_position[0].ord - 97
      row = piece_position[1]-1
      @board[row][column] = piece.symbol 
    end

    for piece in @black.pieces
      piece_position = piece.position
      column = piece_position[0].ord - 97
      row = piece_position[1]-1
      @board[row][column] = piece.symbol 
    end
  end
end