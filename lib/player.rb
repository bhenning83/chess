require_relative 'clearable'
require_relative 'savable'

require 'json'

class Player
  include Clearable 
  include Savable
  attr_accessor :board, :pieces, :piece, :new_spot, :old_spot
  attr_reader :color, :taken_piece

  def initialize(color, board, pieces, white_pieces, black_pieces)
    @color = color
    @board = board
    @pieces = pieces
    @white_pieces = white_pieces
    @black_pieces = black_pieces
    @piece = nil
    @new_spot = nil
    @old_spot = nil
    @taken_piece = nil
    @player_turn = color
    @path = '/Users/brendonhenning/the_odin_project/ruby/chess/saves/'
  end

  def select_piece
    puts "#{color}, select piece to move\nor type \'save\' to save game."
    input = input_getter
    if input[0] > 7 || input[0] < 0 || input[1] > 7 || input[1] < 0
      select_piece
      return nil
    end
    @piece = board[input[1]][input[0]]
    @piece.pos = input unless piece == ' - '
    select_piece if invalid?(input)
  end

  def input_getter
    input = gets.chomp.downcase.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    if input == 'save'.split(//)
      save
      select_piece
      return
    end
    input[0] = input_converter(input[0]) if input[0].match?(/[A-Za-z]/)
    input[0] = input[0].to_i - 1; input[1] = input[1].to_i - 1
    input
  end

  def input_converter(letter)
    return 1 if letter == 'a'
    return 2 if letter == 'b'
    return 3 if letter == 'c'
    return 4 if letter == 'd'
    return 5 if letter == 'e'
    return 6 if letter == 'f'
    return 7 if letter == 'g'
    return 8 if letter == 'h'
  end

  def invalid?(input)
    return true if piece == ' - '
    return true if input.length != 2
    return true if piece.color != self.color
    false
  end

  def select_spot
    puts "Select location to move"
    input = input_getter
    if input[0] > 7 || input[0] < 0 || input[1] > 7 || input[1] < 0
      select_spot
      return nil
    end
    @new_spot = input.dup
  end

  def valid_spot?
    @piece.find_poss_moves
    return false unless piece.valid?(new_spot)
    return false unless piece.clear?(new_spot)
    temp_spot = board[new_spot[1]][new_spot[0]]
    unless temp_spot == ' - '
      return false if temp_spot.color == self.color
    end
    true
  end

  def pick_again
    unless valid_spot?
      puts "Invalid move, try again.\n\n"
      select_move_info
      return nil
    end
  end

  def select_move_info
    select_piece
    select_spot
    pick_again
    return unless valid_spot?
  end

  def move
    @old_spot = piece.dup.pos 
    @taken_piece = board[new_spot[1]][new_spot[0]] #for refence when deleting from list of player's pieces
    board[new_spot[1]][new_spot[0]] = piece.dup
    board[old_spot[1]][old_spot[0]] = ' - ' #when it goes twice, this overrides
    @piece.pos = new_spot.dup
  end

end