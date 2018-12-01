require 'open3'
require 'csv'
require 'fileutils'

target_path = ARGV[0]
output, _err, _status = Open3.capture3("python ./main.py #{target_path}")

phash_map = CSV.parse(output).each.with_object({}) do |row, map|
  phash = row.first
  filename = row[1]
  filepath = File.join(target_path, filename).to_s
  next unless File.exist?(filepath)

  if map[phash]
    puts "delete! duplicated: #{phash}: #{filename}"
    FileUtils.rm(filepath)
  else
    map[phash] = filename
  end
end.invert

filenames = phash_map.keys.sort
duplicateds = []

def to_binary(phash)
  sprintf("%064b", phash.to_i(16))
end

def hamming_distance(source, compared)
  source.split('').zip(compared.split('')).count { |i, j| i.to_i ^ j.to_i == 1 }
end

filenames.each do |filename_a|
  filepath_a = File.join(target_path, filename_a)
  next unless File.exist?(filepath_a)
  phash_a = phash_map[filename_a]
  # next if duplicateds.include?(phash_a)

  filenames.each do |filename_b|
    filepath_b = File.join(target_path, filename_b)
    next unless File.exist?(filepath_b)

    phash_b = phash_map[filename_b]
    # next if duplicateds.include?(phash_b)
    diff =  hamming_distance(to_binary(phash_a), to_binary(phash_b))
    puts "#{diff}, file: #{filename_a}: #{phash_a}, #{filename_b}: #{phash_b}"
    if diff <= 10
      puts "delete! #{filename_b}"
      FileUtils.rm(filepath_b)
      duplicateds << phash_b
    end
  end
  filenames.delete(filename_a)
end

puts "dupulicated #{duplicateds.size}"
