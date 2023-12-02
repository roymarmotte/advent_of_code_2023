# frozen_string_literal: true

letter_nbs = %w[zero one two three four five six seven eight nine]

numbers = File.readlines('./input.txt').map do |line|
  result = []
  10.times do |i|
    digit = line.enum_for(:scan, /(?=#{i})/).map do
      Regexp.last_match.offset(0).first
    end
    letter_digit = line.enum_for(:scan, /(?=#{letter_nbs[i]})/).map do
      Regexp.last_match.offset(0).first
    end

    digit.each { result[_1] = i }
    letter_digit.each { result[_1] = i }
  end

  result.compact!

  (result.first.to_s + result.last.to_s).to_i
end
pp numbers.sum
