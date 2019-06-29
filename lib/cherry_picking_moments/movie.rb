require 'cherry_picking_moments/phash'

class CherryPickingMoments::Movie
  def initialize(moviepath)
    @moviepath = moviepath
  end

  def phashes
    return @phashes if @phashes

    @phashes = []
    Dir.glob(File.join(@moviepath, '*.png')) do |filepath|
      @phashes << CherryPickingMoments::Phash.new(filepath)
    end
    @phashes
  end
end