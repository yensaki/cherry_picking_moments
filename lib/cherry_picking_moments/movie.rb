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
    Dir.glob(File.join(parapara!.output_path, '*.png')).sort.each do |filepath|
      image = CherryPickingMoments::Image.new(filepath)
      if (prev_image = @images.last)
        prev_image.following_distance = prev_image.distance_from(image)
      end

      @images << image
    end
    @images
  end

  private

  def parapara!
    @parapara ||= CherryPickingMoments::Parapara.new(@moviepath).tap(&:slice!)
  end
end