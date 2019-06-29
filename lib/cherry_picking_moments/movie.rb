require 'cherry_picking_moments/parapara'
require 'cherry_picking_moments/image'
require 'cherry_picking_moments/hamming_distance'

class CherryPickingMoments::Movie
  def initialize(moviepath)
    @moviepath = moviepath
  end

  def images
    return @images if @images

    @images = []
    Dir.glob(File.join(parapara!.output_path, '*.png')) do |filepath|
      image = CherryPickingMoments::Image.new(filepath)
      prev_image = @images.last
      prev_image.following_distance = CherryPickingMoments::HammingDistance.new(prev_image, image).hamming_distance if prev_image

      @images << image
    end
    @images
  end

  private

  def parapara!
    @parapara ||= CherryPickingMoments::Parapara.new(@moviepath).tap(&:slice!)
  end
end