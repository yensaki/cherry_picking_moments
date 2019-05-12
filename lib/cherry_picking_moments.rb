require 'cherry_picking_moments/version'
require 'fileutils'
require 'cherry_picking_moments/parapara.rb'
require 'cherry_picking_moments/imagehash.rb'
require 'cherry_picking_moments/similar_images.rb'

module CherryPickingMoments
  def self.hamming_distances(source_file)
    parapara = Parapara.new(source_file)
    parapara.slice!

    phash_map = ImageHash.phash_map(parapara.output_path)
    psimilar_images = SimilarImages.new(phash_map)
    psimilar_images.calc_diff
    phash_map
  end
end
