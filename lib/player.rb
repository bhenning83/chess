class Player
  attr_accessor :board, :pieces, :king, :piece
  attr_reader :color

  def initialize(color, board, pieces, king)
    @color = color
    @board = board
    @pieces = pieces
    @king = king
    @piece = nil
  end

  def select_piece
    puts 'select piece'
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    piece = board[input[1]][input[0]]
  end
end