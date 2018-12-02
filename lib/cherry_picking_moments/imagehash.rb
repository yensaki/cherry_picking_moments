require 'pycall/import'
include PyCall::Import

module CherryPickingMoments
  module ImageHash
    pyimport :imagehash
    pyfrom :PIL, import: :Image

    def self.phash_map(target_path)
      phash_map = Hash.new([])
      Dir.glob(File.join(target_path, '*.jpg')) do |filepath|
        filename = File.basename(filepath)
        pyimage = Image.open(filepath)
        phash = imagehash.phash(pyimage).to_s
        phash_map[phash] += [filename]
      end
      phash_map
    end

    def self.dhash_map(target_path)
      dhash_map = Hash.new([])
      Dir.glob(File.join(target_path, '*.jpg')) do |filepath|
        filename = File.basename(filepath)
        pyimage = Image.open(filepath)
        dhash = imagehash.dhash(pyimage).to_s
        dhash_map[dhash] += [filename]
      end
      dhash_map
    end
  end
end
