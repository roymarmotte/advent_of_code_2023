# frozen_string_literal: true

def replace_occurences(array, state_order)
  array.map do |i|
    order = state_order.select { |h| i.between?(h[:source], h[:source] + h[:length]) }.first
    if order.nil?
      i
    else
      order[:dest] + (i - order[:source])
    end
  end
end

FINAL_STATE = 'location'
input = File.readlines('./input.txt')
seeds_line = input.first
seeds = seeds_line.split(':').last.scan(/\d+/).map(&:to_i)
states = { 'seed' => seeds }
from_state_name = 'seed'
to_state_name = 'seed'
state_order = []

input[1..].each do |line|
  next if line.strip.empty?

  if /[a-zA-Z]+/.match? line
    states[to_state_name] = replace_occurences(states[to_state_name], state_order)
    state_order = []
    from_to_str = line.split('map').first
    from_state_name = from_to_str.split('-to-').first.strip
    to_state_name = from_to_str.split('-to-').last.strip
    states[to_state_name] = states[from_state_name].dup
  else
    dest, source, length = line.scan(/\d+/).map(&:to_i)
    state_order << { dest: dest, source: source, length: length }
  end
end

states[to_state_name] = replace_occurences(states[to_state_name], state_order)
pp states[FINAL_STATE].min
