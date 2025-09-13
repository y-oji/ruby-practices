#!/usr/bin/env ruby
# frozen_string_literal: true

def acquire_files
  Dir.glob('*')
end

def acquire_max_length(files)
  max_length = 0
  files.each { |file| max_length = file.length if file.length > max_length }
  max_length
end

def create_array(files, columns)
  count = files.size
  rows = count / columns

  rows += 1 if (count % columns).positive?

  array = []
  rows.times { array << [] }

  files.each_with_index do |file, index|
    row = index % rows
    array[row] << file
  end

  array
end

def organize_file(array, column_length)
  array.each do |row|
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

files = acquire_files
display_files(files, 3)
