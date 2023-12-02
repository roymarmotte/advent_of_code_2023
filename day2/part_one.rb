# frozen_string_literal: true

COLORS = %w[red green blue].freeze
MAX_COLOR = { 'red' => 12, 'green' => 13, 'blue' => 14 }.freeze

results = File.readlines('./input.txt').map do |line|
  game_name, games = line.split(':')
  game_nb = game_name.scan(/\d/).join.to_i
  games = games.split(';')

  error = games.any? do |game|
    MAX_COLOR.any? do |key, value|
      nb = game.scan(/(\d+)(?=\s*#{key})/).first&.first&.to_i

      !nb.nil? && nb > value
    end
  end
  error ? 0 : game_nb
end
pp results.sum
