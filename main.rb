require 'open3'
require 'csv'
require 'fileutils'
require 'pycall/import'
require_relative 'parapara.rb'
require_relative 'imagehash.rb'
require_relative 'similar_images.rb'

source_file = ARGV[0]
target_path = ARGV[1]

FileUtils.mkdir_p(target_path)

Parapara.new(source_file, target_path).slice!

phash_map = ImageHash.hash_map(target_path)

phash_map = phash_map.invert

similar_images = SimilarImages.new(phash_map, target_path)

similar_images.uniquish!

# puts "deleted duplicated: #{duplicated_count}"
puts "deleted neary: #{similar_images.deleted_nearies.size}"
