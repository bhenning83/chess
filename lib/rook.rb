require_relative 'playable'
require_relative 'clearable'
require_relative 'game'
require_relative 'king'
require 'pry'

class Rook < Game
  include Playable
  include Clearable
  attr_accessor :pos, :board, :poss_moves

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @poss_moves = []
  end

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end

  def find_poss_moves
    find_poss_moves_v
    find_poss_moves_h
  end

  def find_poss_moves_v
    current = pos.dup
    (0..7).each do |i|
      current[1] = i
      next if current == pos
      poss_moves << current.dup
    end
  end

  def find_poss_moves_h
    current = pos.dup
    (0..7).each do |i|
      current[0] = i
      next if current == pos
      poss_moves << current.dup
    end
  end
end

  game = Game.new
  rook = Rook.new([5, 5], 'black', game.board)
  #game.board[5][5] = King.new([5, 5], 'black', game.board)
  puts rook.clear?([1, 5])
  p game.display_board
  rook.find_poss_moves
  p rook.poss_moves
