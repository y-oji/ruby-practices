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
  rows, remainder = count.divmod(columns)
  rows += 1 if remainder.positive?

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

files = acquire_files
columns = 3
display_files(files, columns)
