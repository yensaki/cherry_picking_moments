require 'pycall/import'
include PyCall::Import

module CherryPickingMoments
  module ImageHash
    pyimport :imagehash
    pyfrom :PIL, import: :Image

    def self.phash_map(target_path)
      phash_map = []
      Dir.glob(File.join(target_path, '*.png')) do |filepath|
        pyimage = Image.open(filepath)
        phash = imagehash.phash(pyimage).to_s
        phash_map << Phash.new(filepath, phash)
      end
      phash_map
    end

    class Phash
      attr_reader :filepath, :phash
      attr_accessor :next_image_diff

      def initialize(filepath, phash)
        @filepath = filepath
        @phash = phash
      end
    end
  end
end
