require 'phashion'

class CherryPickingMoments::Image
  attr_reader :filepath
  attr_accessor :following_distance

  def initialize(filepath)
    @filepath = filepath
  end

  def distance_from(image)
    phashion_image.distance_from(image.phashion_image)
  end

  def phashion_image
    @phashion_image ||= Phashion::Image.new(@filepath)
  end
end
