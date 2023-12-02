# frozen_string_literal: true

COLORS = %w[red green blue].freeze
MAX_COLOR = { 'red' => 12, 'green' => 13, 'blue' => 14 }.freeze

results = File.readlines('./input.txt').map do |line|
  games = line.split(':').last
  games = games.split(';')
  colors_nb = { 'red' => 0, 'green' => 0, 'blue' => 0 }

  games.each do |game|
    COLORS.each do |color|
      nb = game.scan(/(\d+)(?=\s*#{color})/).first&.first&.to_i
      colors_nb[color] = nb if !nb.nil? && nb > colors_nb[color]
    end
  end
  colors_nb.values.inject(:*)
end
pp results.sum
