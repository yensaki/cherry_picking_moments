require 'open3'
require 'csv'
require 'fileutils'
require_relative 'parapara.rb'

require 'pycall/import'
include PyCall::Import
pyimport :imagehash
pyfrom :PIL, import: :Image

source_file = ARGV[0]
target_path = ARGV[1]

Parapara.new(source_file, target_path).slice!

phash_map = {}

duplicated_count = 0
Dir.glob(File.join(target_path, '*.jpg')) do |filepath|
  filename = File.basename(filepath)
  pyimage = Image.open(filepath)
  phash = imagehash.phash(pyimage).to_s
  if phash_map[phash]
    puts "delete! duplicated: #{phash}: #{filename}"
    FileUtils.rm(filepath)
    duplicated_count += 1
  else
    phash_map[phash] = filename
  end
end

phash_map = phash_map.invert

filenames = phash_map.keys.sort
deleted_nearies = []

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
      deleted_nearies << phash_b
    end
  end
  filenames.delete(filename_a)
end

puts "deleted duplicated: #{duplicated_count}"
puts "deleted neary: #{deleted_nearies.size}"
