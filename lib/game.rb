# create a board
# write move method for each piece
#   each piece will need to know all of it's possible moves
#     After each move, every piece must see if the opposing king is in it's valid, clear path
#       if the king is in check, loop through each possible move of each remaining piece on defensive team
#         at each possible defensive move, check every possible offensive move from every offensive piece
#         if king is still in check, move to next possible defensive move on king's side
#         break if king is never in check after checking every offensive move against a single defensive move
#         declare checkmate if all possible defensive moves on king's side are exhausted and king remains in check
# all game pieces can overtake opponent in their legal path, except pawns
# players will have to first input the coord of the piece they want to move
#   each player will need a piece_log
#   cycle throught eh piece_log to find the piece at the matching coordinate
#   assign that piece at that coordinate to an instance variable
#   get user input on where to move it to
#   check if it's valid
#   change coordinate of the piece
# clear can't be run when finding poss_moves because when checking check, a piece could move out of the original pass and those new moves wouldn't be listed

require_relative 'playable'
require_relative 'clearable'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'player'

require 'pry'

class Game
  include Playable
  attr_accessor :board, :white_pieces, :black_pieces, :player1, :player2
  attr_accessor :kingw, :kingb, :white_pieces_storage, :black_pieces_storage
  
  def initialize
    @board = make_board
    @white_pieces = []
    @black_pieces = []
    @white_pieces_storage = []
    @black_pieces_storage = []
    @player1 = Player.new('white', @board, make_white_army)
    @player2 = Player.new('black', @board, make_black_army)
  end

  def make_white_army
    pawn1w = Pawn.new([0, 1], 'white', board, ' ♟︎ ')
    pawn2w = Pawn.new([1, 1], 'white', board, ' ♟︎ ')
    pawn3w = Pawn.new([2, 1], 'white', board, ' ♟︎ ')
    pawn4w = Pawn.new([3, 1], 'white', board, ' ♟︎ ')
    pawn5w = Pawn.new([4, 1], 'white', board, ' ♟︎ ')
    pawn6w = Pawn.new([5, 1], 'white', board, ' ♟︎ ')
    pawn7w = Pawn.new([6, 1], 'white', board, ' ♟︎ ')
    pawn8w = Pawn.new([7, 1], 'white', board, ' ♟︎ ')
    white_pieces << pawn1w
    white_pieces << pawn2w
    white_pieces << pawn3w
    white_pieces << pawn4w
    white_pieces << pawn5w
    white_pieces << pawn6w
    white_pieces << pawn7w
    white_pieces << pawn8w
    rook1w = Rook.new([0, 0], 'white', board, ' ♜ ')
    rook2w = Rook.new([7, 0], 'white', board, ' ♜ ')
    knight1w = Knight.new([1, 0], 'white', board, ' ♞ ')
    knight2w = Knight.new([6, 0], 'white', board, ' ♞ ')
    bishop1w = Bishop.new([2, 0], 'white', board, ' ♝ ')
    bishop2w = Bishop.new([5, 0], 'white', board, ' ♝ ')
    queenw = Queen.new([3, 0], 'white', board, ' ♛ ')
    kingw = King.new([4, 0], 'white', board, ' ♚ ')
    white_pieces << rook1w
    white_pieces << rook2w
    white_pieces << knight1w
    white_pieces << knight2w
    white_pieces << bishop1w
    white_pieces << bishop2w
    white_pieces << queenw
    white_pieces << kingw
    white_pieces
  end

  def make_black_army
    pawn1b = Pawn.new([0, 6], 'black', board, ' ♙ ')
    pawn2b = Pawn.new([1, 6], 'black', board, ' ♙ ')
    pawn3b = Pawn.new([2, 6], 'black', board, ' ♙ ')
    pawn4b = Pawn.new([3, 6], 'black', board, ' ♙ ')
    pawn5b = Pawn.new([4, 6], 'black', board, ' ♙ ')
    pawn6b = Pawn.new([5, 6], 'black', board, ' ♙ ')
    pawn7b = Pawn.new([6, 6], 'black', board, ' ♙ ')
    pawn8b = Pawn.new([7, 6], 'black', board, ' ♙ ')
    black_pieces << pawn1b 
    black_pieces << pawn2b 
    black_pieces << pawn3b 
    black_pieces << pawn4b 
    black_pieces << pawn5b 
    black_pieces << pawn6b 
    black_pieces << pawn7b 
    black_pieces << pawn8b
    rook1b = Rook.new([0, 7], 'black', board, ' ♖ ')
    rook2b = Rook.new([7, 7], 'black', board, ' ♖ ')
    knight1b = Knight.new([1, 7], 'black', board, ' ♘ ')
    knight2b = Knight.new([6, 7], 'black', board, ' ♘ ')
    bishop1b = Bishop.new([2, 7], 'black', board, ' ♗ ')
    bishop2b = Bishop.new([5, 7], 'black', board, ' ♗ ')
    queenb = Queen.new([3, 7], 'black', board, ' ♕ ')
    kingb = King.new([4, 7], 'black', board, ' ♔ ')
    black_pieces << rook1b
    black_pieces << rook2b
    black_pieces << knight1b
    black_pieces << knight2b
    black_pieces << bishop1b
    black_pieces << bishop2b
    black_pieces << queenb
    black_pieces << kingb
    black_pieces
  end

  def set_board
    white_pieces.each do |piece|
      board[piece.pos[1]][piece.pos[0]] = piece
    end
    black_pieces.each do |piece|
      board[piece.pos[1]][piece.pos[0]] = piece
    end
  end

  def find_black_king
    board.each do |key, value|
      value.each do |piece|
        next if piece == ' - '
        if piece.symbol == ' ♔ '
         idx = value.index(piece)
         return [idx, key]
        end
      end
    end
  end

  def find_white_king
    board.each do |key, value|
      value.each do |piece|
        next if piece == ' - '
        if piece.symbol == ' ♚ '
         idx = value.index(piece)
         return [idx, key]
        end
      end
    end
  end

  def checkw?
    target = find_black_king
    white_pieces.each do |piece|
      piece.find_poss_moves
      player1.piece = piece
      piece.poss_moves.each do |move|
        player1.new_spot = move
        next unless player1.valid_spot?
        return true if move == target
      end
    end
    false
  end

  def checkb?
    target = find_white_king
    black_pieces.each do |piece|
      piece.find_poss_moves
      player2.piece = piece
      piece.poss_moves.each do |move|
        player2.new_spot = move
        next unless player2.valid_spot?
        return true if move == target
      end
    end
    false
  end

  def checkmatew?
    black_pieces.each do |piece|
      temp_piece = piece.dup
      temp_piece.find_poss_moves
      player2.piece = temp_piece
      temp_piece.poss_moves.each do |poss_move| #cycle through every legal move of every opponent piece to try to block check
        play_out_move(poss_move, player2)
        unless checkw?
          reset_board(temp_piece, piece, player2)
          return false
        end
        reset_board(temp_piece, piece, player2)
      end
    end
    true
  end

  def checkmateb?
    white_pieces.each do |piece|
      temp_piece = piece.dup
      temp_piece.find_poss_moves
      player1.piece = temp_piece
      temp_piece.poss_moves.each do |poss_move| #cycle through every legal move of every opponent piece to try to block check
        play_out_move(poss_move, player1)
        unless checkb?
          reset_board(temp_piece, piece, player1)
          return false
        end
        reset_board(temp_piece, piece, player1)
      end
    end
    true
  end

  def reset_board(temp_piece, piece, player)
    board[temp_piece.pos[1]][temp_piece.pos[0]] = ' - '
    board[piece.pos[1]][piece.pos[0]] = piece
    replace_taken_piece(player)
    set_board
  end

  #temporarily moves defender's pieces to try to block check
  def play_out_move(poss_move, player)
    player.new_spot = poss_move
    return unless player.valid_spot?
    player.move
    attack(player)
  end

   #removes a taken piece from that player's list of pieces
   def attack(player)
    if player == player1
      return if player1.taken_piece == ' - '
      black_pieces.delete(player1.taken_piece)
    else
      return if player2.taken_piece == ' - '
      white_pieces.delete(player2.taken_piece)
    end
  end

  # to use so hypothetical moves don't permanently delete
  # from the piece list
  def replace_taken_piece(player)
    if player == player1
      return if player1.taken_piece == ' - '
      black_pieces << player1.taken_piece
    else
      return if player2.taken_piece == ' - '
      white_pieces << player2.taken_piece
    end
  end 

  def test
    display_board
    player1.select_move_info
    player1.move
    attack(player1)
    display_board
    player2.select_move_info
    player2.move
    attack(player2)
    display_board
    player1.select_move_info
    player1.move
    attack(player1)
    display_board
    player2.select_move_info
    player2.move
    attack(player2)
    display_board
    player1.select_move_info
    player1.move
    attack(player1)
    display_board
    player2.select_move_info
    player2.move
    attack(player2)
    display_board
  end
end

game = Game.new
game.set_board
game.test
