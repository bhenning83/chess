require 'pry'
require_relative 'clearable'
class Player
  include Clearable
  attr_accessor :board, :pieces, :piece, :new_spot
  attr_reader :color, :taken_piece

  def initialize(color, board, pieces)
    @color = color
    @board = board
    @pieces = pieces
    @piece = nil
    @new_spot = nil
    @taken_piece = nil
  end

  def select_piece
    puts "#{color}, select piece to move"
    input = input_getter
    if input[0] > 7 || input[0] < 0 || input[1] > 7 || input[1] < 0
      select_piece
      return nil
    end
    @piece = board[input[1]][input[0]]
    piece.pos = input unless piece == ' - '
    select_piece if invalid?(input)
  end

  def input_getter
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    input[0] = input_converter(input[0]) if input[0].match?(/[A-Za-z]/)
    input[0] = input[0].to_i - 1; input[1] = input[1].to_i - 1
    input
  end

  def input_converter(letter)
    letter.upcase!
    return 1 if letter == 'A'
    return 2 if letter == 'B'
    return 3 if letter == 'C'
    return 4 if letter == 'D'
    return 5 if letter == 'E'
    return 6 if letter == 'F'
    return 7 if letter == 'G'
    return 8 if letter == 'H'
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
      puts "Invalid move, try again."
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
    old_spot = piece.dup.pos 
    @taken_piece = board[new_spot[1]][new_spot[0]] #for refence when deleting from list of player's pieces
    board[new_spot[1]][new_spot[0]] = piece.dup
    board[old_spot[1]][old_spot[0]] = ' - ' #when it goes twice, this overrides
    @piece.pos = new_spot.dup
  end

end