# frozen_string_literal: true

numbers = File.readlines('./input.txt').map do |line|
  sorted_line = line.scan(/\d/)

  (sorted_line.first + sorted_line.last).to_i
end
pp numbers
pp numbers.sum
