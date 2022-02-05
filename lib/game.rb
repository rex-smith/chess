require_relative 'board'
require_relative 'player'
require_relative 'save_load'

class Game
  include SaveLoad
  def initialize
    
  end

  def choose_game_type
    response = ''
    loop do
      puts "Would you like to load an old game? (Y/N)"
      response = gets.chomp.downcase
      if response == 'y' || response == 'n'
        break
      end
      puts "Please enter Y or N"
    end
    response == 'y' ? load_game : new_game
  end

  def new_game
    @board = Board.new
    @board.white.initialize_pieces
    @board.black.initialize_pieces
  end

  def play_game
    @board.updateBoard
    until game_over? do
      @board.displayBoard
      @board.active_player.play_turn
      @board.change_active
      @board.updateBoard
    end
    end_game
  end

  def game_over?
    checkmate? || stalemate?
  end
  
  def end_game
    if checkmate?
      puts "Checkmate! #{@board.active_enemy} wins the game!"
    elsif stalemate?
      puts "Stalemate!"
    end
  end

  def checkmate?
    # Conditions: In Check
    # No possible moves
    if @board.active_player.check? && @board.active_player.total_moves_no_check.length == 0
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
    if !@board.active_player.check? && @board.active_player.total_moves_no_check.length == 0
      return true
    end
    return false
  end
end
