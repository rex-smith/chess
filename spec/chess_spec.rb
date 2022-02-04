require_relative '../lib/main'
require_relative '../lib/game'
require_relative '../lib/board'
require_relative '../lib/player'
require_relative '../lib/piece'
require_relative '../lib/space'

# # GAME FILE
# describe Game do
  
# end

# BOARD FILE
describe Board do

  describe '#select_piece' do
    context 'when a piece exists at that spot' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      fake_board.updateBoard
      it 'returns the selected piece object' do
        expect(fake_board.select_piece([4,5])).to eq(king)
      end
    end

    context 'when a piece does not exist at that spot' do
      it 'returns an empty array' do
        # test
      end
    end
  end
  
  describe 'onBoard?' do
    fake_board = Board.new
    context 'when the position is not on the board' do
      it 'returns false' do
        expect(fake_board.onBoard?([9,9])).to be false
      end
    end
    
    context 'when the position is on the board' do
      it 'returns true' do
        expect(fake_board.onBoard?([3,3])).to be true
      end
    end
  end

  

  describe '#contains_piece?' do
    fake_board = Board.new

    context 'when the space does contain a piece' do
      bishop = Bishop.new(fake_board.white, [3,4])
      fake_board.updateBoard
      it 'returns true' do
        expect(fake_board.contains_piece?([3,4])).to be true
      end
    end
    
    context 'when the space does not contain a piece' do
      it 'returns false' do
        expect(fake_board.contains_piece?([6,6])).to be false
      end
    end
  end

  describe '#change_active' do
    fake_board = Board.new
    context 'when active is white' do
      it 'changes active to black' do
        expect {fake_board.change_active}.to change { fake_board.active_player}.to(fake_board.black)
      end
    end

    context 'when active is black' do
      it 'changes active to white' do
        expect {fake_board.change_active}.to change { fake_board.active_player}.to(fake_board.white)
      end
    end
  end
end

# PLAYER FILE
describe Player do
  describe '#check?' do
    context 'when active player is in check on board' do
      fake_board = Board.new
      fake_player = fake_board.white
      king = King.new(fake_board.white, [4,5])
      enemy_bishop = Bishop.new(fake_board.black, [1,2])
      fake_board.updateBoard
      it 'returns true' do
        expect(fake_player.check?).to be true
      end
    end

    context 'when active player is not in check' do
      fake_board = Board.new
      fake_player = fake_board.white
      king = King.new(fake_board.white, [4,5])
      enemy_bishop = Bishop.new(fake_board.black, [3,2])
      fake_board.updateBoard
      it 'returns false' do
        expect(fake_player.check?).to be false
      end
    end
  end

  describe '#possibleMoves' do
    context 'when the game starts' do
      it 'returns array of all possible moves' do
        # test
      end
    end

    context 'when the game is in the middle' do
      it 'returns small array of all possible moves' do
        # test
      end
    end

    context 'when the current player is in checkmate' do
      it 'returns an empty array' do
        # test
      end
    end
  end



  describe '#choose_move' do
    context 'when the chose move is valid' do
      it 'returns the valid move in piece, location format' do
        # test
      end
    end

    context 'when the move is not valid, then valid' do
      it 'requests the move twice before returning the correct move' do
        # test
      end
    end
  end

  describe '#move' do
    # Don't need to test since just a script
  end

  describe '#capture_opponent' do

    context 'when there is an opponent in the space' do
      fake_board = Board.new
      fake_player = fake_board.white
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [1,2])
      fake_board.updateBoard
      it 'adds the opponents piece to their removed pieces array' do
        fake_player.capture_opponent([1,2])
        expect(fake_player.enemy.removed_piece).to eq(enemy_bishop)
      end
    end

    context 'when there is an opponent in the space' do
      fake_board = Board.new
      fake_player = fake_board.white
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [1,2])
      fake_board.updateBoard
      it 'adds the opponents piece to their removed pieces array' do
        expect {fake_player.capture_opponent([1,2])}.to change {fake_player.enemy.pieces.length}.by(-1)
      end
    end

    context 'when there is no opponent in the space' do
      fake_board = Board.new
      fake_player = fake_board.white
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [1,1])
      fake_board.updateBoard
      it 'does nothing' do
        expect {fake_player.capture_opponent([1,2])}.not_to change {fake_player.enemy.pieces.length}
      end
    end
  end

  describe '#move_piece' do
    context 'when the move is legitimate' do
      it 'updates the board with the pieces new location and removes the old' do
        # test
      end
    end
  end

  describe '#occupied_enemy?' do
    fake_board = Board.new
    context 'when the position is occupied by the enemy' do
      bishop = Bishop.new(fake_board.black, [3,4])
      fake_board.updateBoard
      it 'returns true' do
        expect(fake_board.white.occupied_enemy?([3,4])).to be true
      end
    end

    context 'when the position is not occupied by the enemy' do
      it 'returns false' do
        expect(fake_board.white.occupied_enemy?([1,2])).to be false
      end
    end
  end

  describe '#occupied_self?' do
    fake_board = Board.new
    context 'when it is not occupied by yourself' do
      it 'returns false' do
        expect(fake_board.white.occupied_self?([5,4])).to be false
      end
    end

    context 'when it is occupied by yourself' do
      bishop = Bishop.new(fake_board.white, [3,4])
      fake_board.updateBoard
      it 'returns true' do
        expect(fake_board.white.occupied_self?([3,4])).to be true
      end
    end
  end
end

# PIECES FILE

describe WhitePawn do
  describe '#moves_pre_check' do
    context 'when not blocked and no enemies to capture' do
      fake_board = Board.new
      pawn = WhitePawn.new(fake_board.white, [1,6])
      it 'returns one space' do
        expect(pawn.moves_pre_check[0]).to eq([1,5])
      end
    end

    context 'when not blocked and straight would put in check' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [1,2])
      fake_board.updateBoard
      it 'returns one space' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([[3,3]])
      end
    end

    context 'when blocked by enemy' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [3,3])
      fake_board.updateBoard
      it 'returns empty array' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([])
      end
    end

    context 'when blocked by self' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns empty array' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to eq([])
      end
    end

    context 'when ahead is empty, and corners are occupied by enemy' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [2,3])
      enemy_bishop_2 = Bishop.new(fake_board.black, [4,3])
      fake_board.updateBoard

      it 'returns array with three moves' do
        potential_moves = pawn.moves_pre_check
        expect(potential_moves).to match_array([[2,3], [4,3], [3,3]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when not blocked' do
      fake_board = Board.new
      pawn = WhitePawn.new(fake_board.white, [1,6])
      king = King.new(fake_board.white, [4,7])
      fake_board.updateBoard
      it 'returns one space' do
        expect(pawn.moves_no_check).to eq([[1,5]])
      end
    end

    context 'when not blocked but move would put in check' do
      fake_board = Board.new
      king = King.new(fake_board.white, [4,5])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      enemy_bishop = Bishop.new(fake_board.black, [1,2])
      fake_board.updateBoard
      it 'returns empty array' do
        expect(pawn.moves_no_check).to eq([])
      end
    end
  end
end

describe Rook do
  describe '#moves_pre_check' do
    context 'when all moves are good' do
      fake_board = Board.new
      rook = Rook.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns all spaces up and across' do
        move_array = rook.moves_pre_check
        expect(move_array).to match_array([[2,3], [1,3], [0,3], [4,3], [5,3], [6,3], [7,3],
                                           [3,2], [3,1], [3,0], [3,4], [3,5], [3,6], [3,7]])
      end
    end

    context 'when blocked by enemy' do
      fake_board = Board.new
      rook = Rook.new(fake_board.white, [3,3])
      enemy_bishop = Bishop.new(fake_board.black, [3,5])
      fake_board.updateBoard
      it 'returns all moves not blocked by enemy' do
        move_array = rook.moves_pre_check
        expect(move_array).to match_array([[2,3], [1,3], [0,3], [4,3], [5,3], [6,3], [7,3],
                                           [3,2], [3,1], [3,0], [3,4], [3,5]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when no move would put in check' do
      fake_board = Board.new
      rook = Rook.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns all moves' do
        move_array = rook.moves_pre_check
        expect(move_array).to match_array([[2,3], [1,3], [0,3], [4,3], [5,3], [6,3], [7,3],
                                           [3,2], [3,1], [3,0], [3,4], [3,5], [3,6], [3,7]])
      end
    end

    context 'when moving up would put in check' do
      fake_board = Board.new
      rook = Rook.new(fake_board.white, [3,3])
      enemy_queen = Queen.new(fake_board.black, [0,3])
      king = King.new(fake_board.white, [6,3])
      fake_board.updateBoard
      it 'returns only lateral moves' do
        move_array = rook.moves_no_check
        expect(move_array).to match_array([[2,3], [1,3], [0,3], [4,3], [5,3]])
      end
    end
  end
end

describe Knight do
  describe '#moves_pre_check' do
    context 'when all moves are good' do
      fake_board = Board.new
      knight = Knight.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'shows all moves' do
        move_array = knight.moves_pre_check
        expect(move_array).to match_array([[5,4], [4,5], [5,2], [2,5], [1,4], [4,1], [1,2], [2,1]])
      end
    end

    context 'when blocked by self' do
      fake_board = Board.new
      knight = Knight.new(fake_board.white, [3,3])
      king = King.new(fake_board.white, [5,2])
      fake_board.updateBoard
      it 'shows all moves except blocked one' do
        move_array = knight.moves_pre_check
        expect(move_array).to match_array([[5,4], [4,5], [2,5], [1,4], [4,1], [1,2], [2,1]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when all moves are good' do
      fake_board = Board.new
      knight = Knight.new(fake_board.white, [3,3])
      king = King.new(fake_board.white, [5,3])
      fake_board.updateBoard
      it 'returns all moves' do
        move_array = knight.moves_no_check
        expect(move_array).to match_array([[5,4], [4,5], [5,2], [2,5], [1,4], [4,1], [1,2], [2,1]])
      end
    end

    context 'when moving at all would put into check' do
      fake_board = Board.new
      knight = Knight.new(fake_board.white, [3,3])
      enemy_rook = Rook.new(fake_board.black, [1,3])
      king = King.new(fake_board.white, [5,3])
      fake_board.updateBoard
      it 'returns an empty array' do
        move_array = knight.moves_no_check
        expect(move_array).to match_array([])
      end
    end
  end
end

describe Bishop do
  describe '#moves_pre_check' do
    context 'when board is completely open' do
      it 'returns all spaces in diagonals on board from space' do
        fake_board = Board.new
        bishop = Bishop.new(fake_board.white, [3,3]) 
        move_array = bishop.moves_pre_check
        expect(move_array).to match_array([[0,0], [1,1], [2,2], [4,4], [5,5], [6,6], [7,7],
                                          [6,0], [5,1], [4,2], [2,4], [1,5], [0,6]])
      end
    end

    context 'when can capture' do
      it 'returns all spaces in diagonals on board from space until capture spot' do
        fake_board = Board.new
        bishop = Bishop.new(fake_board.white, [1,2]) 
        enemy_king = King.new(fake_board.black, [4,5])
        king = King.new(fake_board.white, [0,6])
        fake_board.updateBoard
        move_array = bishop.moves_pre_check
        expect(move_array).to match_array([[2, 3], [3, 4], [2, 1], [4,5], [3, 0], [0, 3], [0, 1]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when leaving the current position would ensure check unless you went diagonal' do
      it 'returns only moves on diagonal to attacking bishop' do
        fake_board = Board.new
        bishop = Bishop.new(fake_board.white, [3,3])
        enemy_bishop =  Bishop.new(fake_board.black, [6,0])
        king = King.new(fake_board.white, [0,6])
        fake_board.updateBoard
        move_array = bishop.moves_no_check
        expect(move_array).to match_array([[6,0],[5,1],[4,2],[2,4],[1,5]])
      end
    end
  end
end

describe Queen do
  describe '#moves_pre_check' do
    context 'when nothing is blocking' do
      fake_board = Board.new
      queen = Queen.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns all spaces possible' do
        move_array = queen.moves_pre_check
        expect(move_array).to match_array([[2,2], [1,1], [0,0], [4,4], [5,5], [6,6], [7,7], [2,4],
                                           [1,5], [0,6], [4,2], [5,1], [6,0], [2,3], [1,3], [0,3],
                                           [4,3], [5,3], [6,3], [7,3], [3,2], [3,1], [3,0], [3,4],
                                           [3,5], [3,6], [3,7]])
      end
    end

    context 'when being blocked by own team' do
      fake_board = Board.new
      queen = Queen.new(fake_board.white, [3,3])
      bishop = Bishop.new(fake_board.white, [3,4])
      fake_board.updateBoard
      it 'returns everything not blocked' do
        move_array = queen.moves_pre_check
        expect(move_array).to match_array([[2,2], [1,1], [0,0], [4,4], [5,5], [6,6], [7,7], [2,4],
                                           [1,5], [0,6], [4,2], [5,1], [6,0], [2,3], [1,3], [0,3],
                                           [4,3], [5,3], [6,3], [7,3], [3,2], [3,1], [3,0]])
      end
    end

    context 'when blocked by opponent' do
      fake_board = Board.new
      queen = Queen.new(fake_board.white, [3,3])
      enemy_bishop = Bishop.new(fake_board.black, [3,4])
      fake_board.updateBoard
      it 'returns blocked space (for capture) and all not blocked' do
        move_array = queen.moves_pre_check
        expect(move_array).to match_array([[2,2], [1,1], [0,0], [4,4], [5,5], [6,6], [7,7], [2,4],
                                           [1,5], [0,6], [4,2], [5,1], [6,0], [2,3], [1,3], [0,3],
                                           [4,3], [5,3], [6,3], [7,3], [3,2], [3,1], [3,0], [3,4]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when all moves are good' do
      fake_board = Board.new
      queen = Queen.new(fake_board.white, [3,3])
      king = King.new(fake_board.white, [0,7])
      fake_board.updateBoard
      it 'returns all moves' do
        move_array = queen.moves_no_check
        expect(move_array).to match_array([[2,2], [1,1], [0,0], [4,4], [5,5], [6,6], [7,7], [2,4],
                                           [1,5], [0,6], [4,2], [5,1], [6,0], [2,3], [1,3], [0,3],
                                           [4,3], [5,3], [6,3], [7,3], [3,2], [3,1], [3,0], [3,4],
                                           [3,5], [3,6], [3,7]])
      end
    end

    context 'when any non diagonal move puts in check' do
      fake_board = Board.new
      queen = Queen.new(fake_board.white, [3,3])
      king = King.new(fake_board.white, [5,5])
      enemy_bishop = Bishop.new(fake_board.black, [1,1])
      fake_board.updateBoard
      it 'returns only diagonal moves' do
        move_array = queen.moves_no_check
        expect(move_array).to match_array([[2,2], [1,1], [4,4]])
      end
    end
  end
end

describe King do
  describe '#moves_pre_check' do
    context 'when all moves available' do
      fake_board = Board.new
      king = King.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns array of all moves' do
        move_array = king.moves_pre_check
        expect(move_array).to match_array([[2,3], [2,4], [2,2], [3,2], [3,4], [4,3], [4,4], [4,2]])
      end
    end

    context 'when same color piece is blocking' do
      fake_board = Board.new
      king = King.new(fake_board.white, [3,3])
      pawn = WhitePawn.new(fake_board.white, [3,4])
      fake_board.updateBoard
      it 'returns all spaces but one' do
        move_array = king.moves_pre_check
        expect(move_array).to match_array([[2,3], [2,4], [2,2], [3,2], [4,3], [4,4], [4,2]])
      end
    end

    context 'when there is an enemy to capture' do
      fake_board = Board.new
      king = King.new(fake_board.white, [3,3])
      enemy_bishop =  Bishop.new(fake_board.black, [2,2])
      fake_board.updateBoard
      it 'returns an array of all moves' do
        move_array = king.moves_pre_check
        expect(move_array).to match_array([[2,3], [2,4], [2,2], [3,2], [3,4], [4,4], [4,3], [4,2]])
      end
    end
  end

  describe '#moves_no_check' do
    context 'when no moves put into check' do
      fake_board = Board.new
      king = King.new(fake_board.white, [3,3])
      fake_board.updateBoard
      it 'returns all moves' do
        move_array = king.moves_no_check
        expect(move_array).to match_array([[2,3], [2,4], [2,2], [3,2], [3,4], [4,3], [4,4], [4,2]])
      end
    end

    context 'when one move puts it into check' do
      fake_board = Board.new
      king = King.new(fake_board.white, [3,3])
      enemy_bishop =  Bishop.new(fake_board.black, [2,2])
      fake_board.updateBoard
      it 'returns all moves but one' do
        move_array = king.moves_no_check
        expect(move_array).to match_array([[2,3], [2,4], [2,2], [3,2], [3,4], [4,3], [4,2]])
      end
    end
  end
end

describe Space do
  describe '#numberPosition' do
    context 'when given a character position' do
      let(:num_test) { Class.new { extend Space } }
      it 'returns the number position' do
        num_position = num_test.numberPosition('a2')
        expect(num_position).to eq([0,6])
      end
    end
  end

  describe '#charPosition' do
    context 'when given a number position' do
      let(:char_test) { Class.new { extend Space } }
      it 'returns the character position' do
        char_position = char_test.charPosition([0,6])
        expect(char_position).to eq('a2')
      end
    end
  end
end
