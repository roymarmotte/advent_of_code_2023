digit = {"one": "1", "two": "2", "three": "3", "four": "4", "five": "5", "six": "6", "seven": "7", "eight": "8", "nine": "9" }

def string_to_number(i, digit)
  digit.each do |key, value|
    key = key.to_s
    if i.include?(key)
      i.gsub!(key, "#{key}#{value}#{key[-1]}")
    end
  end
  i
end

all_numbers = File.readlines('./input.txt').map do |i|
  string = string_to_number(i, digit)
  string.gsub!(/[^0-9]/, '')
  i.split('')
end


result = 0

all_numbers.each do |n|
  l = n[0] + n[-1]
  result += l.to_i
end
puts result