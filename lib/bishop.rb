require_relative 'playable'
require_relative 'game'
require_relative 'clearable'
require 'pry'

class Bishop < Game
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
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert
    false
  end

  def find_poss_moves
    find_poss_moves_right
    find_poss_moves_left
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
end
game = Game.new
bishop = Bishop.new([3, 2], 'black', game.board)
p game.display_board
bishop.find_poss_moves
p bishop.poss_moves
