require_relative 'game'
require_relative 'king'
require 'pry'

class Knight < Game
  attr_accessor :pos, :board, :poss_moves

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @moves = [[-1, 2], [-1, -2], [-2, -1], [-2, 1], [1, 2], [1, -2], [2, 1], [2, -1]]
    @board = board
    @poss_moves = []
  end

  def valid?(new_spot)
    location = []
    @moves.each do |move|
      @pos.each_index do |i|
        location[i] = @pos[i] + move[i]
        return true if location == new_spot
      end
    end
    false
  end

  def find_poss_pos(poss_pos = [])
    @moves.each do |move|
      pos.each_index do |i|
        poss_pos[i] = pos[i] + move[i]
      end
      next unless on_board?(poss_pos)
      poss_moves << poss_pos.dup
    end
  end

  def on_board?(poss_pos)
    poss_pos.each do |value|
      return false if value > 7 || value < 0
    end
    true
  end
end

game = Game.new
knight = Knight.new([1,1], 'white', game.board)
game.board[2][3] = King.new('black', [2, 3], game.board)
knight.find_poss_pos
p knight.poss_moves