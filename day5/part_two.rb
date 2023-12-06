# frozen_string_literal: true

def overlap_range(rangea, rangeb)
    begin_nb = rangea.begin < rangeb.begin ? rangea.begin : rangeb.begin
    end_nb = rangea.end > rangeb.end ? rangea.end : rangeb.end
    (begin_nb..end_nb)
  end
  
  def is_overlaps(rangea, rangeb)
    rangea.cover?(rangeb.begin) || rangeb.cover?(rangea.begin)
  end
  
  def idn(seed, step, dest)
    beg = seed.cover?(step.begin) ? step.begin : seed.begin
    ed = seed.cover?(step.end) ? step.end : seed.end
    to_change = (dest...dest + (ed - step.begin))
  
    if beg > seed.begin
      [(seed.begin...beg), to_change]
    else
      [(ed...seed.end), to_change]
    end
  end
  # def replace_occurences(array, state_order)
  #   array.map do |i|
  #     order = state_order.select { |h| i.between?(h[:source], h[:source] + h[:length]) }.first
  #     if order.nil?
  #       i
  #     else
  #       order[:dest] + (i - order[:source])
  #     end
  #   end
  # end
  
  # def apply_step(seed, steps)
  #   steps.inject(seed) do |seed_value, step|
  #   end
  # end
  
  FINAL_STATE = 'location'
  input = File.readlines('./example.txt')
  seeds_line = input.first
  seeds_unprocessed = seeds_line.split(':').last.split.map(&:to_i).each_slice(2)
  seeds = seeds_unprocessed.flat_map { |useed| (useed.first...(useed.first + useed.last)) }
  steps = []
  input[1..].each do |line|
    next if line.strip.empty?
  
    if /[a-zA-Z]+/.match? line
      steps << {}
    else
      dest, source, length = line.scan(/\d+/).map(&:to_i)
      steps.last[(source...source + length)] = dest
    end
  end.compact
  # pp steps
  # result = seeds.map do |seed|
  #   seed.tap do |s|
  #     steps_pos = steps.map do |step|
  #       step.select { |key| s.between?(key.begin, key.end) }
  #     end.compact.inject(:merge)
  #     pp steps_pos
  #     steps_pos.each do |key, value|
  #       s = value + (s - key.begin)
  #     end
  #   end
  # end
  pp steps
  steps.each do |step|
    pp step
    seeds = seeds.flat_map do |seed|
      # pp "ALUH #{seed}"
      process = step.select { |key, _value| is_overlaps(seed, key) }
      if process.empty?
        seed
      else
        process_range = process.keys.first
        process_value = process.values.first
        if process_range.cover?(seed)
          # puts "COVER #{seed} #{process_range}"
          (process_value...(process_value + (seed.end - process_range.begin)))
        else
          # puts "NOT COVER #{seed} #{process_range}"
          ola = idn(seed, process_range, process_value)
          # pp ola
          ola
        end
      end
    end.uniq
    pp seeds
    
  end
  
  pp seeds.map(&:begin).min
  # seeds.map {|seed| apply_step(seed, steps)}
  # states = { 'seed' => seeds }
  # from_state_name = 'seed'
  # to_state_name = 'seed'
  # state_order = []
  
  # input[1..].each do |line|
  #   next if line.strip.empty?
  
  #   if /[a-zA-Z]+/.match? line
  #     states[to_state_name] = replace_occurences(states[to_state_name], state_order)
  #     state_order = []
  #     from_to_str = line.split('map').first
  #     from_state_name = from_to_str.split('-to-').first.strip
  #     to_state_name = from_to_str.split('-to-').last.strip
  #     states[to_state_name] = states[from_state_name].dup
  #   else
  #     dest, source, length = line.scan(/\d+/).map(&:to_i)
  #     state_order << { dest: dest, source: source, length: length }
  #   end
  # end
  
  # states[to_state_name] = replace_occurences(states[to_state_name], state_order)
  # pp states[FINAL_STATE].min
  