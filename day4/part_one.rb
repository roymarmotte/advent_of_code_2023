# frozen_string_literal: true

input = File.readlines('./input.txt')

results = input.map do |line|
  _game_name, game = line.split(':')
  winning_nb, drawn_nb = game.split('|')

  winning_nb = winning_nb.scan(/\d+/).map(&:to_i)
  drawn_nb = drawn_nb.scan(/\d+/).map(&:to_i)

  good_nb = drawn_nb & winning_nb
  good_nb.each_index.map { |key, _value| key.zero? ? 1 : 2 }.inject(:*)
end
pp results.compact.sum
