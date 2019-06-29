require 'cherry_picking_moments/parapara'
require 'cherry_picking_moments/phash'
require 'cherry_picking_moments/hamming_distance'

class CherryPickingMoments::Movie
  def initialize(moviepath)
    @moviepath = moviepath
  end

  def phashes
    return @phashes if @phashes

    @phashes = []
    Dir.glob(File.join(parapara!.output_path, '*.png')) do |filepath|
      phash = CherryPickingMoments::Phash.new(filepath)
      prev_phash = @phashes.last
      prev_phash.following_distance = CherryPickingMoments::HammingDistance.new(prev_phash, phash).hamming_distance if prev_phash

      @phashes << phash
    end
    @phashes
  end

  private

  def parapara!
    @parapara ||= CherryPickingMoments::Parapara.new(@moviepath).tap(&:slice!)
  end
end