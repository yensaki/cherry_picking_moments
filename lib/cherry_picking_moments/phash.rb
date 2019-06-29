require 'pycall/import'
include PyCall::Import

class CherryPickingMoments::Phash
  attr_reader :filepath
  attr_accessor :next_image_diff
  pyfrom :PIL, import: :Image

  def initialize(filepath)
    @filepath = filepath
    pyimport :imagehash
  end

  def phash
    @phash ||= imagehash.phash(pyimage).to_s
  end

  private

  def pyimage
    @pyimage ||= Image.open(@filepath)
  end
end
