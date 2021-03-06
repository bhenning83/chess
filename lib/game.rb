require_relative 'playable'
require_relative 'clearable'
require_relative 'knight'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'pawn'
require_relative 'player'
require_relative 'savable'

require 'json'

class Game
  include Playable
  include Savable
  attr_accessor :board, :white_pieces, :black_pieces, :player1, :player2, :game_over
  
  def initialize
    @board = make_board
    @white_pieces = []
    @black_pieces = []
    @player1 = Player.new('white', @board, make_white_army, @white_pieces, @black_pieces)
    @player2 = Player.new('black', @board, make_black_army, @white_pieces, @black_pieces)
    @path = '/Users/brendonhenning/the_odin_project/ruby/chess/saves/'
    @player_turn = nil
    @game_over = false
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
    white_pieces << pawn1w << pawn2w << pawn3w << pawn4w << pawn5w << pawn6w << pawn7w << pawn8w
    rook1w = Rook.new([0, 0], 'white', board, ' ♜ ')
    rook2w = Rook.new([7, 0], 'white', board, ' ♜ ')
    knight1w = Knight.new([1, 0], 'white', board, ' ♞ ')
    knight2w = Knight.new([6, 0], 'white', board, ' ♞ ')
    bishop1w = Bishop.new([2, 0], 'white', board, ' ♝ ')
    bishop2w = Bishop.new([5, 0], 'white', board, ' ♝ ')
    queenw = Queen.new([3, 0], 'white', board, ' ♛ ')
    kingw = King.new([4, 0], 'white', board, ' ♚ ')
    white_pieces << rook1w << rook2w << knight1w << knight2w << bishop1w << bishop2w << queenw << kingw
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
    black_pieces << pawn1b << pawn2b << pawn3b << pawn4b << pawn5b << pawn6b << pawn7b << pawn8b
    rook1b = Rook.new([0, 7], 'black', board, ' ♖ ')
    rook2b = Rook.new([7, 7], 'black', board, ' ♖ ')
    knight1b = Knight.new([1, 7], 'black', board, ' ♘ ')
    knight2b = Knight.new([6, 7], 'black', board, ' ♘ ')
    bishop1b = Bishop.new([2, 7], 'black', board, ' ♗ ')
    bishop2b = Bishop.new([5, 7], 'black', board, ' ♗ ')
    queenb = Queen.new([3, 7], 'black', board, ' ♕ ')
    kingb = King.new([4, 7], 'black', board, ' ♔ ')
    black_pieces << rook1b << rook2b << knight1b << knight2b << bishop1b << bishop2b << queenb << kingb
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

  def check?(player)
    if player == player1
      puts "YOU ARE IN CHECK." if checkb?
    else
      puts "YOU ARE IN CHECK." if checkw?
    end
  end

  def checkmate?(player)
    return if @game_over == true #prevents double announcement
    if player == player1
      if checkmatew?
        puts "\nCheckmate. White wins!"
        @game_over = true
      end
    else
      if checkmateb?
        puts "\nCheckmate. Black wins!" 
        @game_over = true
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

  def prevent_move_into_check(player)
    prevent_move_into_checkw if player == player1
    prevent_move_into_checkb if player == player2
  end

  def prevent_move_into_checkw
    if checkb?
      board[player1.old_spot[1]][player1.old_spot[0]] = player1.piece
      player1.piece.pos = player1.old_spot.dup
      board[player1.new_spot[1]][player1.new_spot[0]] = ' - '
      replace_taken_piece(player1)
      play_turn(player1)
    end
  end

  def prevent_move_into_checkb
    if checkw?
      board[player2.old_spot[1]][player2.old_spot[0]] = player2.piece
      player2.piece.pos = player2.old_spot.dup
      board[player2.new_spot[1]][player2.new_spot[0]] = ' - '
      replace_taken_piece(player2)
      play_turn(player2)
    end
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

  #temporarily moves defender's pieces to try to block check
  def play_out_move(poss_move, player)
    player.new_spot = poss_move
    return unless player.valid_spot?
    player.move
    attack(player)
  end

  def reset_board(temp_piece, piece, player)
    board[temp_piece.pos[1]][temp_piece.pos[0]] = ' - '
    board[piece.pos[1]][piece.pos[0]] = piece
    temp_piece.pos = piece.pos
    replace_taken_piece(player)
    set_board
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
  
  def play_turn(player)
    display_board
    check?(player)
    player.select_move_info
    player.move
    attack(player)
    prevent_move_into_check(player)
    checkmate?(player)
    @player_turn = nil
  end

  def play_game
    ask_to_load
    set_board
    until @game_over == true
      play_turn(player1) unless @player_turn == 'black'
      play_turn(player2) unless @game_over == true
    end
  end
end