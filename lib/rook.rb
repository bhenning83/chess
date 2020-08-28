require_relative 'playable'
require_relative 'clearable'
require 'pry'

class Rook
  include Playable
  include Clearable
  attr_accessor :pos, :board, :poss_moves
  attr_reader :symbol, :color

  def initialize(pos, color, board, symbol)
    @pos = pos
    @color = color
    @board = board
    @poss_moves = []
    @symbol = symbol
    find_poss_moves
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