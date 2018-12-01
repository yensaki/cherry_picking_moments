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
    FileUtils.rm(filepath)
  else
    map[phash] = filename
  end
end

phashes = phash_map.keys
simillaries = {}
duplicateds = []

def to_binary(phash)
  sprintf("%064b", phash.to_i(16))
end

def hamming_distance(source, compared)
  source.split('').zip(compared.split('')).count { |i, j| i.to_i ^ j.to_i == 1 }
end

phashes.each do |phash_a|
  # next if duplicateds.include?(phash_a)

  phashes.each do |phash_b|
    # next if duplicateds.include?(phash_b)
    next if phash_a == phash_b

    diff =  hamming_distance(to_binary(phash_a), to_binary(phash_b))
    puts "#{diff}, file: #{phash_map[phash_a]}, #{phash_map[phash_b]}"
    if diff <= 20
      simillaries[phash_a] ||= []
      simillaries[phash_a] |= [phash_a, phash_b]
      duplicateds += [phash_a, phash_b]
    end
  end
end

puts "dupulicated #{duplicateds.size}"

count = 0
simillaries.each_value do |array|
  array.delete(array.sample)
  array.each do |phash|
    filename = phash_map[phash]
    puts filename

    filepath = File.join(target_path, filename).to_s
    FileUtils.rm(filepath) if File.exist?(filepath)
    count += 1
  end
end

puts "deleted #{count}"