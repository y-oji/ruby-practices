#!/usr/bin/env ruby

require 'date'
require 'optparse'

today = Date.today
year = today.year
month = today.month

OptionParser.new do |opts|
  opts.on("-y ",Integer) { |y| year = y }
  opts.on("-m ",Integer) { |m| month = m }
end.parse!

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

first_wday = first_day.wday
print "   " * first_wday

(first_day..last_day).each do |day|
  everyday = day.day.to_s.rjust(2)
  print day == today ? "\e[7m#{everyday}\e[0m " : "#{everyday} "

  puts if day.saturday?
end

puts unless last_day.saturday?

puts
