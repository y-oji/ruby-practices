# !/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

COLUMNS = 3

options = { all: false, reverse: false }

OptionParser.new do |opts|
  opts.on('-a') { options[:all] = true }
  opts.on('-r') { options[:reverse] = true }
end.parse!

def acquire_files(options)
  files = Dir.glob('*', *(options[:all] ? [File::FNM_DOTMATCH] : []))
  files = files.reverse if options[:reverse]
  files
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
display_files(files, COLUMNS)
