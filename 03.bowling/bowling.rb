#!/usr/bin/env ruby

score = ARGV[0]
scores = score.split(',')
shots = []

scores.each do |s|
  if s == 'X'
    shots << 10
  else
    shots << s.to_i
  end
end

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

frame10 = []

if i < shots.size
  frame10.push(shots[i])
end

if i + 1 < shots.size
  frame10.push(shots[i + 1])
end

if (frame10[0] == 10) || (frame10[0] + frame10[1] == 10)
  if i + 2 < shots.size
    frame10.push(shots[i + 2])
  end
end

frames.push(frame10)

point = 0
frames.each do |frame|
  point += frame.sum
end
puts point
