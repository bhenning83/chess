require_relative 'clearable'
require_relative 'savable'

class Rook
  include Clearable
  include Savable

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

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end

  def find_poss_moves
    @poss_moves = []
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