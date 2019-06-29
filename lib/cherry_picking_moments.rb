require 'cherry_picking_moments/version'
require 'cherry_picking_moments/movie.rb'

module CherryPickingMoments
  def self.hamming_distances(source_file)
    Movie.new(source_file).phashes
  end
end
