require 'pry'
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
    puts "#{color}, select piece to move"
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
    input[0] = input[0].to_i 
    input[1] = input[1].to_i
    @piece = board[input[1]][input[0]]
    select_piece if invalid?(input)
  end

  def invalid?(input)
    return true if piece == ' - '
    return true if input.length != 2
    return true if piece.nil?
    return true if piece.color != color
    false
  end

  def move
    input = gets.chomp.strip.gsub(/[{}()<>\[\] ,]/, '').split(//)
  end
end