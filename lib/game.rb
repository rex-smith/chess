require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
  end

  def play_game
    until game_over? do
      @board.updateBoard
      @board.displayBoard
      @board.active_player.move
    end
  end

  def game_over?

  end

  def checkmate?

  end

  def stalemate?

  end
end
