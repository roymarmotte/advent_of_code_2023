# frozen_string_literal: true

CHAR_NOT_SPE = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', nil].freeze
input = File.read('input.txt').split("\n")

def get_begin_number(input, x, y)
  line = input[y]
  char = line[x]

  while x != -1 && (0..9).map(&:to_s).include?(char)
    x -= 1
    char = input[y][x]
  end
  x == -1 ? 0 : x + 1
end

def check_around(input, x, y)
  # pp "pos #{y} #{x}"
  line = input[y]
  char = line&.split('')&.dig(x)
  return false unless (0..9).map(&:to_s).include? char

  right = [y, x + 1]
  left = [y, x - 1]
  top = [y + 1, x]
  bot = [y - 1, x]
  right_top = [y - 1, x + 1]
  left_top = [y - 1, x - 1]
  right_bot = [y + 1, x + 1]
  left_bot = [y + 1, x - 1]
  all_pos = [right, left, top, bot, right_top, left_top, right_bot, left_bot]

  all_pos.any? do |pos|
    line_pos = input[pos.first]
    if line_pos.nil? || pos.first.negative?
      false
    else
      !CHAR_NOT_SPE.include?(line_pos[pos.last])
    end
  end
end

results = input.each_with_index.flat_map do |line, y|
  line.split('').each_with_index.map do |_char, x|
    is_ok = check_around(input, x, y)

    if is_ok
      nb_pos = get_begin_number(input, x, y)
      nb = line[nb_pos..].scan(/\d+/).first
      nb_end_pos = nb_pos + nb.size - 1
      line[nb_pos..nb_end_pos] = '.' * nb.size
      nb.to_i
    else
      0
    end
  end
end
pp results.sum
