require 'json'
require 'pry'

module Savable
  def to_json(*_args)
    JSON.dump({
                type: self.class,
                pos: @pos,
                color: @color,
                symbol: @symbol
              })
  end

  def save_piece_lists
    JSON.dump({
                white_pieces: @white_pieces.each { |piece| piece.to_json},
                black_pieces: @black_pieces.each { |piece| piece.to_json}
              })
  end

  def save
    puts 'Enter a name for your saved game.'
    save_name = gets.chomp
    stream = save_piece_lists
    File.open(@path + save_name, 'w') { |f| f.puts stream }
    puts 'Game saved. Do you want to quit your game? yes/no'
    if gets.chomp.downcase == 'yes'
      puts 'k bye'
      exit 
    end
  end

  def load
    puts 'What is the name of your saved game?'
    answer = gets.chomp
    save = File.read(@path + answer)
    data = JSON.parse(save)
    load_piece_lists(data)
    @loaded = true
  end

  def create_from_json(piece_data, ary)
    type = piece_data['type'] #gives str
    type = Object.const_get(type) #converts str to literal
    piece = type.new(piece_data['pos'], piece_data['color'], @board, piece_data['symbol'])
    ary << piece
    ary
  end

  def load_piece_lists(data)
    @white_pieces = []; @black_pieces = []
    data['white_pieces'].each { |piece_data| create_from_json(piece_data, @white_pieces)}
    data['black_pieces'].each { |piece_data| create_from_json(piece_data, @black_pieces)}
  end

  def ask_to_load
    puts 'Do you want to start a new game or continue a saved game? new/load'
    return nil unless gets.chomp.strip.downcase == 'load'

    load
  end
end