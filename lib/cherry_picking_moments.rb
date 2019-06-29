require 'cherry_picking_moments/version'
require 'fileutils'
require 'cherry_picking_moments/parapara.rb'
require 'cherry_picking_moments/movie.rb'
require 'cherry_picking_moments/similar_images.rb'

module CherryPickingMoments
  def self.hamming_distances(source_file)
    parapara = Parapara.new(source_file)
    parapara.slice!

    phashes = Movie.new(parapara.output_path).phashes
    psimilar_images = SimilarImages.new(phashes)
    psimilar_images.calc_diff
    phashes
  end
end
