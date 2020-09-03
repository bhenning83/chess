require 'json'
require 'pry'

module Savable
  def to_json(*_args)
    JSON.dump({
                pos: @pos,
                color: @color,
                poss_moves: @poss_moves,
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
    binding.pry
    data = JSON.parse(save)
    binding.pry
    load_piece_lists(save)
    @loaded = true
  end

  def create_from_json(data)
    self.new(data['pos'], data['color'], data['poss_moves'], data['symbol'])
  end

  def load_piece_lists(data)
    test = JSON.parse(data)
    binding.pry
    @white_pieces = test['white_pieces'].each {|piece| piece.create_from_json(test)}
    @black_pieces = test['black_pieces'].each {|piece| piece.create_from_json(test)}
  end

  def ask_to_load
    puts 'Do you want to start a new game or continue a saved game? new/load'
    return nil unless gets.chomp.strip.downcase == 'load'

    load
  end
end