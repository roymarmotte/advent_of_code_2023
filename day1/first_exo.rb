numbers = File.readlines('./input.txt').map do |line|
  sorted_line = line.scan(/\d/)
  pp line
  pp sorted_line
  (sorted_line.first + sorted_line.last).to_i
end
pp numbers
pp numbers.sum