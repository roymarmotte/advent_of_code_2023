# frozen_string_literal: true

CHAR_NOT_SPE = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '.', nil].freeze
input = File.read('input.txt').split("\n")

def find_end_number(line, x, way)
  nb_list = (0..9).map(&:to_s)
  x += way while !line[x].nil? && x != 0 && nb_list.include?(line[x])
  x
end

def check_around(input, x, y)
  numbers = []

  line = input[y]
  up_line = input[y - 1].nil? ? '' : input[y - 1]
  down_line = input[y + 1].nil? ? '' : input[y + 1]

  left_pos = (x - 1).negative? ? 0 : x - 1
  right_pos = (x + 1)

  up_left_pos = find_end_number(up_line, left_pos, -1)
  up_right_pos = find_end_number(up_line, right_pos, 1)
  middle_left_pos = find_end_number(line, left_pos, -1)
  middle_right_pos = find_end_number(line, right_pos, 1)
  down_left_pos = find_end_number(down_line, left_pos, -1)
  down_right_pos = find_end_number(down_line, right_pos, 1)

  up = up_line[up_left_pos..up_right_pos]
  down = down_line[down_left_pos..down_right_pos]
  middle = line[middle_left_pos..middle_right_pos]

  numbers << [up.scan(/\d+/), middle.scan(/\d+/), down.scan(/\d+/)]
  numbers.flatten.map(&:to_i)
end

results = input.each_with_index.flat_map do |line, y|
  line.split('').each_with_index.map do |char, x|
    next unless char == '*'

    numbers = check_around(input, x, y)
    next if numbers.count != 2

    numbers.inject(:*)
  end
end
pp results.compact.sum
