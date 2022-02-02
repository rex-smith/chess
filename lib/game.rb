require_relative 'board'
require_relative 'player'

class Game
  def initialize
    @board = Board.new
  end

  def play_game
    @board.updateBoard
    @board.displayBoard
    until game_over? do
      @board.updateBoard
      @board.displayBoard
      @board.active_player.play_turn
      @board.change_active
    end
    end_game
  end

  def game_over?
    checkmate? || stalemate?
  end
  
  def end_game
    if checkmate?
      puts "Checkmate! #{@board.active_player} wins the game!"
    elsif stalemate?
      puts "Stalemate!"
    end
  end

  def checkmate?
    # Conditions: In Check
    # No possible moves
    if @board.active_enemy.check? && @board.active_enemy.possible_moves.length == 0
      return true
    end
    return false
  end

  def stalemate?
    # # Stalemate piece combos
    # # King vs. King
    # # King Bishop vs. King
    # # King Knight vs. King
    # # King Bishop vs King Bishop (same bishop color)
    # @board.active_player.pieces
    # @board.active_enemy.pieces

    # Or Not in Check and no possible moves
    if !@board.active_player.check? && @board.active_player.possible_moves.length == 0
      return true
    end
    return false
  end
end
