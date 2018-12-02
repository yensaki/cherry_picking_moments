require 'cherry_picking_moments/version'
require 'fileutils'
require 'cherry_picking_moments/parapara.rb'
require 'cherry_picking_moments/imagehash.rb'
require 'cherry_picking_moments/similar_images.rb'

module CherryPickingMoments
  def self.uniquish!(source_file, target_path)
    FileUtils.mkdir_p(target_path)

    Parapara.new(source_file, target_path).slice!

    phash_map = ImageHash.hash_map(target_path)
    phash_map = phash_map.invert

    similar_images = SimilarImages.new(phash_map, target_path)
    similar_images.uniquish!

    # puts "deleted duplicated: #{duplicated_count}"
    puts "deleted neary: #{similar_images.deleted_nearies.size}"
  end
end
