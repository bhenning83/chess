require_relative 'playable'
require_relative 'clearable'
require_relative 'game'
require 'pry'

class Queen < Game
  include Playable
  include Clearable
  attr_accessor :pos, :board, :values
  
  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
  end

  def valid?(new_spot)
    horz = (new_spot[0] - @pos[0]).abs
    vert = (new_spot[1] - @pos[1]).abs
    return true if horz == vert #if moving diagnolly
    return true if new_spot[0] == @pos[0] #if moving vertically
    return true if new_spot[1] == @pos[1] #if moving horizontally
    false
  end
end
game = Game.new
queen = Queen.new([5, 5], 'black', game.board)
game.board[2][2] = Queen.new([2, 2], 'black', game.board)
puts queen.clear?([1, 1])
puts queen.clear?([5, 0])