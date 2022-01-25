require_relative 'player'

class Board
  def initialize
    @board = Array.new(8) {Array.new(8) {' '}}
    @white = Player.new('white')
    @black = Player.new('black')
    @active_player = @white
  end

  attr_reader :active_player

  def displayBoard
    @board.reverse.each_with_index do |row, index|
      print "#{-1*(index-8)} "
      row.each do |symbol|
        print "[#{symbol}]"
      end
      print "\n"
    end
    print "   A  B  C  D  E  F  G  H\n"
    puts
  end

  def updateBoard
    @board = Array.new(8) {Array.new(8) {' '}}

    for piece in @white.pieces
      piece_position = piece.position
      column = piece_position[0].ord - 97
      row = piece_position[1].to_i-1
      @board[row][column] = piece.symbol 
    end

    for piece in @black.pieces
      piece_position = piece.position
      column = piece_position[0].ord - 97
      row = piece_position[1].to_i-1
      @board[row][column] = piece.symbol 
    end
  end
end