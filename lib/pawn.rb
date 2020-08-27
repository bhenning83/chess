require_relative 'playable'
require 'pry'

class Pawn
  include Playable
  attr_accessor :pos, :board, :poss_moves
  attr_reader :color, :symbol

  def initialize(pos, color, board, symbol)
    @pos = pos
    @color = color
    @board = board
    @poss_moves = []
    @symbol = symbol
  end

  def clear?(new_spot)
    return true if poss_moves.include?(new_spot)
    false
  end

  def valid?(new_spot)
    return false if new_spot[0] != pos[0]
    if color == 'white'
      return true if new_spot[1] - pos[1] == 1
    else 
      return true if pos[1] - new_spot[1] == 1
    end
    false
  end

  def check?
    if color == 'white'
      return if pos[1] == 7
      return true if board[pos[1] + 1][pos[0] + 1].is_a?(King)
      return true if board[pos[1] + 1][pos[0] - 1].is_a?(King)
    else 
      return if pos[1] == 0
      return true if board[pos[1] - 1][pos[0] + 1].is_a?(King)
      return true if board[pos[1] - 1][pos[0] - 1].is_a?(King)
    end
    false
  end

  def find_poss_moves
    find_poss_move_black if color == 'black'
    find_poss_move_white if color == 'white'
  end

  def find_poss_move_white
    return if pos[1] == 7
    poss_moves << [pos[0], pos[1] + 1]
    if pos[1] == 1
      poss_moves << [pos[0], pos[1] + 2]
    end
    possible_attacks_white.each do |spot|
      poss_moves << spot
    end
  end

  def possible_attacks_white(pieces = [], attackable = [])
    pieces << board[pos[1] + 1][pos[0] + 1] unless pos[0] == 7
    pieces << board[pos[1] + 1][pos[0] - 1] unless pos[0] == 0
    pieces.each do |piece|
      next if piece == ' - '
      attackable << piece.pos if piece.color == 'black'
    end
    attackable
  end

  def find_poss_move_black
    return if pos[1] == 0
    poss_moves << [pos[0], pos[1] - 1]
    if pos[1] == 6
      poss_moves << [pos[0], pos[1] - 2]
    end
    possible_attacks_black.each do |spot|
      poss_moves << spot
    end
  end

  def possible_attacks_black(pieces = [], attackable = [])
    pieces << board[pos[1] - 1][pos[0] + 1] unless pos[0] == 7
    pieces << board[pos[1] - 1][pos[0] - 1] unless pos[0] == 0
    pieces.each do |piece|
      next if piece == ' - '
      attackable << piece.pos if piece.color == 'white'
    end
    attackable
  end
end