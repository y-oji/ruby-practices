# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

COLUMNS = 3

options = { all: false, reverse: false, long: false }

OptionParser.new do |opts|
  opts.on('-a') { options[:all] = true }
  opts.on('-r') { options[:reverse] = true }
  opts.on('-l') { options[:long] = true }
end.parse!

def acquire_files(options)
  files = Dir.glob('*', options[:all] ? File::FNM_DOTMATCH : 0)
  files = files.reverse if options[:reverse]
  files
end

def file_type(file)
  File.directory?(file) ? 'd' : '-'
end

PERMISSION_TABLE = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

def permission_string(stat)
  mode = stat.mode.to_s(8)
  permission_number = mode[-3..]
  permission = ''
  permission_number.each_char do |number|
    permission += PERMISSION_TABLE[number]
  end

  permission
end

def put_long_format_in_one_line(file)
  stat = File.lstat(file)
  type = file_type(file)
  permission = permission_string(stat)
  nlink = stat.nlink.to_s.rjust(2)
  owner = Etc.getpwuid(stat.uid).name
  group = Etc.getgrgid(stat.gid).name
  size = stat.size.to_s.rjust(5)
  time = stat.mtime.strftime('%_m %2e %H:%M')

  "#{type}#{permission} #{nlink} #{owner} #{group} #{size} #{time} #{file}"
end

def display_long_format(files)
  total_blocks = 0

  files.each do |file|
    stat = File.lstat(file)
    total_blocks += stat.blocks
  end

  puts "total #{total_blocks}"
  files.each do |file|
    puts put_long_format_in_one_line(file)
  end
end

def acquire_max_length(files)
  files.map(&:length).max
end

def create_array(files, columns)
  count = files.size
  rows = count.ceildiv(columns)

  file_rows = []
  rows.times { file_rows << [] }

  files.each_with_index do |file, index|
    row = index % rows
    file_rows[row] << file
  end

  file_rows
end

def organize_file(file_rows, column_length)
  file_rows.each do |row|
    row.each do |file|
      print file.ljust(column_length + 2)
    end
    puts
  end
end

def display_files(files, columns)
  max_length = acquire_max_length(files)
  rows = create_array(files, columns)
  organize_file(rows, max_length)
end

files = acquire_files(options)

if options[:long]
  display_long_format(files)
else
  display_files(files, COLUMNS)
end
