require_relative 'clearable'

class Queen
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

  def valid?(new_spot)
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert #if moving diagnolly
    return true if new_spot[0] == @pos[0] #if moving vertically
    return true if new_spot[1] == @pos[1] #if moving horizontally
    false
  end

  def find_poss_moves
    @poss_moves = []
    find_poss_moves_right
    find_poss_moves_left
    find_poss_moves_v
    find_poss_moves_h
  end

  def find_poss_moves_right
    start = pos[0] - pos[1]
    current = [start - 1, -1]
    8.times do
      current[0] += 1
      current[1] += 1
      next if current[0] < 0 || current[0] > 7
      next if current == pos
      @poss_moves << current.dup
    end
  end

  def find_poss_moves_left
    start = pos[0] + pos[1]
    current = [start + 1, -1]
    8.times do
      current[0] -= 1
      current[1] += 1
      next if current[0] < 0 || current[0] > 7
      next if current == pos
      @poss_moves << current.dup
    end
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