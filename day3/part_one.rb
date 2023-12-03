# frozen_string_literal: true

CHAR_NOT_SPE = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', nil].freeze
input = File.read('input.txt').split("\n").map { _1.split(//) }

def check_around(input, x, y)
  right = [x + 1, y]
  left = [x - 1, y]
  top = [x, y + 1]
  bot = [x, y - 1]
  right_top = [x + 1, y + 1]
  left_top = [x - 1, y + 1]
  right_bot = [x + 1, y - 1]
  left_bot = [x - 1, y - 1]
  all_pos = [right, left, top, bot, right_top, left_top, right_bot, left_bot]

  all_pos.any? do |pos|
    !CHAR_NOT_SPE.include?(input.dig(*pos))
  end
end

def get_number(line, x)
  line.join[x..].scan(/\d+/).first.to_i
end

results = input.each_with_index.flat_map do |line, y|
  line.each_with_index.map do |_char, x|
    is_ok = check_around(input, x, y)
    is_ok ? get_number(line, x) : 0
  end
end
pp results.sum