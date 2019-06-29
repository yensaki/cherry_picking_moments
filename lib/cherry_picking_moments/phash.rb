require 'pycall/import'
include PyCall::Import

class CherryPickingMoments::Phash
  attr_reader :filepath
  attr_accessor :following_distance
  pyfrom :PIL, import: :Image

  def initialize(filepath)
    @filepath = filepath
    pyimport :imagehash
  end

  def phash
    @phash ||= imagehash.phash(pyimage).to_s
  end

  def to_binary
    sprintf("%064b", phash.to_i(16))
  end

  private

  def pyimage
    @pyimage ||= Image.open(@filepath)
  end
end
