#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = scores.map { |s| s == 'X' ? 10 : s.to_i }

frames = []
i = 0

while i < shots.size && frames.size < 9
  if shots[i] == 10
    frames << [10]
    i += 1
  else
    frames << [shots[i], shots[i + 1]]
    i += 2
  end
end

frame10 = shots[i, 3]
frames.push(frame10)

point = 0

frames.each_with_index do |frame, index|
  if index == 9
    point += frame.sum
  elsif frame[0] == 10
    next_frame = frames[index + 1]
    if next_frame[0] == 10 && index + 2 < frames.size
      next_next_frame = frames[index + 2]
      point += 10 + 10 + next_next_frame[0]
    else
      point += 10 + next_frame[0] + next_frame[1]
    end
  elsif frame.sum == 10
    next_frame = frames[index + 1]
    point += 10 + next_frame[0]
  else
    point += frame.sum
  end
end
puts point
