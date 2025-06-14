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

first_date = Date.new(year, month, 1)
last_date = Date.new(year, month, -1)

puts "#{month}月 #{year}".center(20)
puts "日 月 火 水 木 金 土"

first_wday = first_date.wday
print "   " * first_wday

(first_date..last_date).each do |date|
  day_str = date.day.to_s.rjust(2)
  print date == today ? "\e[7m#{day_str}\e[0m " : "#{day_str} "

  puts if date.saturday?
end

puts unless last_date.saturday?

puts
