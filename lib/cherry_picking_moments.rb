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
    psimilar_images.calc_diff
    phash_map
  end
end
