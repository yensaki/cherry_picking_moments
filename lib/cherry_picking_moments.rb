require 'cherry_picking_moments/version'
require 'cherry_picking_moments/movie.rb'

module CherryPickingMoments
  def self.movie(source_file)
    Movie.new(source_file)
  end
end
