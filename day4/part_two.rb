# frozen_string_literal: true

def update_from_to(bonus_card, actual, win, to_add)
  bonus_card.tap do |cards|
    ((actual + 1)..(actual + win)).each do |i|
      cards[i] += to_add
    end
  end
end

input = File.readlines('./input.txt')
bonus_card = Array.new(input.count, 0)
input.each_with_index.map do |line, key|
  _game_name, game = line.split(':')
  winning_nb, drawn_nb = game.split('|')
  winning_nb = winning_nb.scan(/\d+/).map(&:to_i)
  drawn_nb = drawn_nb.scan(/\d+/).map(&:to_i)

  bonus_card[key] += 1
  good_nb = drawn_nb & winning_nb
  update_from_to(bonus_card, key, good_nb.count, bonus_card[key])
end
pp bonus_card.sum
