include_relative 'game'
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
end

knight = Knight.new([1,1], 'white')
p knight.valid_move?([2, 3])