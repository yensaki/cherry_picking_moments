require 'cherry_picking_moments/version'
require 'fileutils'
require 'cherry_picking_moments/parapara.rb'
require 'cherry_picking_moments/imagehash.rb'
require 'cherry_picking_moments/similar_images.rb'

module CherryPickingMoments
  def self.uniquish!(source_file, target_path)
    FileUtils.mkdir_p(target_path)

    Parapara.new(source_file, target_path).slice!

    phash_map = ImageHash.phash_map(target_path)
    psimilar_images = SimilarImages.new(phash_map, target_path)
    psimilar_images.uniquish!(threshold: 10)

    dhash_map = ImageHash.dhash_map(target_path)
    dsimilar_images = SimilarImages.new(dhash_map, target_path)
    dsimilar_images.uniquish!(threshold: 12)

    puts "phash deleted duplicated: #{psimilar_images.duplicateds.size}"
    puts "phash deleted neary: #{psimilar_images.deleted_nearies.size}"
    puts "dhash deleted duplicated: #{dsimilar_images.duplicateds.size}"
    puts "dhash deleted neary: #{dsimilar_images.deleted_nearies.size}"
  end
end
