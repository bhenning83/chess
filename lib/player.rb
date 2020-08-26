class Player
  attr_accessor :board, :pieces, :king
  attr_reader :color

  def initialize(color, board, pieces)
    @color = color
    @board = board
    @pieces = pieces
    @king = nil
  end
end
