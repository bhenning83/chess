require_relative 'playable'
require_relative 'clearable'
require_relative 'game'
require_relative 'king'
require 'pry'

class Rook < Game
  include Playable
  include Clearable
  attr_accessor :pos, :board, :values

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @board = board
    @values = []
  end

  def valid?(new_spot)
    return true if new_spot[0] == @pos[0]
    return true if new_spot[1] == @pos[1]
    false
  end
 
end

  game = Game.new
  rook = Rook.new([7, 5], 'black', game.board)
  #game.board[5][5] = King.new([5, 5], 'black', game.board)
  puts rook.clear?([1, 5])
  p game.display_board