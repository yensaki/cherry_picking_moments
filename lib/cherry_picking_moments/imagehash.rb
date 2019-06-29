require 'pycall/import'
include PyCall::Import

module CherryPickingMoments
  module ImageHash
    pyimport :imagehash
    pyfrom :PIL, import: :Image

    def self.phash_map(target_path)
      phash_map = []
      Dir.glob(File.join(target_path, '*.png')) do |filepath|
        phash_map << Phash.new(filepath)
      end
      phash_map
    end

    class Phash
      attr_reader :filepath
      attr_accessor :next_image_diff

      def initialize(filepath)
        @filepath = filepath
      end

      def phash
        @phash ||= imagehash.phash(pyimage).to_s
      end

      private

      def pyimage
        @pyimage ||= Image.open(@filepath)
      end
    end
  end
end
