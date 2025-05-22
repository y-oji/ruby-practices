#!/usr/bin/env ruby

# ライブラリを使用する
require 'date'
require 'optparse'

# 初期値の設定をする
today = Date.today
year = today.year
month = today.month

# 引数の設定をする
OptionParser.new do |opts|
  opts.on("-y ",Integer) { |y| year = y }
  opts.on("-m ",Integer) { |m| month = m }
end.parse!

# 月の最初の日と最後の日を取得する
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)

# 月を表示する
puts "#{month}月 #{year}".center(20)

# 曜日を表示する
puts "日 月 火 水 木 金 土"

# 月の最初の日の曜日を取得する
first_wday = first_day.wday

# 月の最初の日まで空白を入力する
print "   " * first_wday

# 日付を月初から月末まで表示する
(first_day..last_day).each do |day|

  # 日付を3桁で表示する
  print day.day.to_s.rjust(3, ' ')

  # 土曜日で改行する  
  if day.wday == 6
    puts
  end
end

# 月末が土曜日でない場合に改行する
puts unless last_day.wday == 6

# 最後に改行を追加する
puts
