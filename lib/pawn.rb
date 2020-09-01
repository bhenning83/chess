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
    find_poss_moves
  end

  def clear?(new_spot)
    return true if poss_moves.include?(new_spot)
    false
  end

  def valid?(new_spot) #validity covered in clear?
    true
  end

  def find_poss_moves
    @poss_moves = []
    if color == 'black'
      find_poss_move_black
    else
      find_poss_move_white
    end
    remove_forward_attack
  end

  def remove_forward_attack
    poss_moves.each do |move|
      if pos[0] == move[0]
        spot = board[move[1]][move[0]]
        poss_moves.delete(move) unless spot == ' - '
      end
    end
  end

  def find_poss_move_white(pieces = [])
    return if pos[1] == 7
    poss_moves << [pos[0], pos[1] + 1]
    if pos[1] == 1
      poss_moves << [pos[0], pos[1] + 2]
    end
    possible_attacks_white.each do |spot|
      poss_moves << spot
    end
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

  def possible_attacks_white(pieces = [], attackable = [])
    spot1 = board[pos[1] + 1][pos[0] + 1] unless pos[0] == 7
    spot1.pos = [pos[0] + 1, pos[1] + 1] unless spot1 == ' - ' || spot1.nil?
    spot2 = board[pos[1] + 1][pos[0] - 1] unless pos[0] == 0
    spot2.pos = [pos[0] - 1, pos[1] + 1] unless spot2 == ' - ' || spot2.nil?
    pieces << spot1 unless spot1.nil?
    pieces << spot2 unless spot2.nil?
    pieces.each do |piece|
      next if piece == ' - '
      attackable << piece.pos if piece.color == 'black'
    end
    attackable
  end

  def possible_attacks_black(pieces = [], attackable = [])
    spot1 = board[pos[1] - 1][pos[0] + 1] unless pos[0] == 7
    spot1.pos = [pos[0] + 1, pos[1] - 1] unless spot1 == ' - ' || spot1.nil?
    spot2 = board[pos[1] - 1][pos[0] - 1] unless pos[0] == 0
    spot2.pos = [pos[0] - 1, pos[1] - 1] unless spot2 == ' - ' || spot2.nil?
    pieces << spot1 unless spot1.nil?
    pieces << spot2 unless spot2.nil?
    pieces.each do |piece|
      next if piece == ' - '
      attackable << piece.pos if piece.color == 'white'
    end
    attackable
  end
end