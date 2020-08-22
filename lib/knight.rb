require_relative 'game'
require_relative 'king'
require 'pry'

class Knight < Game
  attr_accessor :pos, :board

  def initialize(pos, color, board)
    @pos = pos
    @color = color
    @moves = [[-1, 2], [-1, -2], [-2, -1], [-2, 1], [1, 2], [1, -2], [2, 1], [2, -1]]
    @board = board
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

  def check?(pot_pos = [])
    @moves.each do |move|
      pos.each_index do |i|
        pot_pos[i] = pos[i] + move[i]
      end
      next unless on_board?(pot_pos)
      return true if @board[pot_pos[1]][pot_pos[0]].is_a?(King)
    end
    false
  end

  def on_board?(coord)
    coord.each do |value|
      return false if value > 7 || value < 0 #creates a virtual 8x8 board
    end
    true
  end
end

game = Game.new
knight = Knight.new([1,1], 'white', game.board)
p knight.valid?([2, 3])
game.board[3][5] = King.new('black', [2, 3], game.board)
p knight.check?
p game.board