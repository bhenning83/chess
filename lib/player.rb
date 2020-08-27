require 'pry'
require_relative 'clearable'
class Player
  include Clearable
  attr_accessor :board, :pieces, :king, :piece, :new_spot
  attr_reader :color

  def initialize(color, board, pieces, king)
    @color = color
    @board = board
    @pieces = pieces
    @king = king
    @piece = nil
    @new_spot = nil
  end

  def select_piece
    puts "#{color}, select piece to move"
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    input[0] = input[0].to_i - 1; input[1] = input[1].to_i - 1
    if input[0] > 7 || input[0] < 0 || input[1] > 7 || input[1] < 0
      select_piece
      return nil
    end
    @piece = board[input[1]][input[0]]
    select_piece if invalid?(input)
  end

  def invalid?(input)
    return true if piece == ' - '
    return true if input.length != 2
    return true if piece.color != self.color
    false
  end

  def select_spot
    puts "Select location to move"
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    input[0] = input[0].to_i - 1; input[1] = input[1].to_i - 1
    if input[0] > 7 || input[0] < 0 || input[1] > 7 || input[1] < 0
      select_spot
      return nil
    end
    @new_spot = input.dup
    select_spot until valid_spot?(new_spot)
  end

  def valid_spot?(new_spot)
    piece.find_poss_moves
    return false unless piece.clear?(new_spot)
    return false unless piece.valid?(new_spot)
    temp_spot = board[new_spot[1]][new_spot[0]]
    unless temp_spot == ' - '
      return false if temp_spot.color == self.color
    end
    true
  end
end