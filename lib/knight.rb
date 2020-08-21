class Knight
  attr_accessor :pos
  def initialize(pos, color)
    @pos = pos
    @color = color
    @moves = [[-1, 2], [-1, -2], [-2, -1], [-2, 1], [1, 2], [1, -2], [2, 1], [2, -1]]
  end

  def valid_move?(new_spot)
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