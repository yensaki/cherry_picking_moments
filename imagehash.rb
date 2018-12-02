require 'pycall/import'
include PyCall::Import

module ImageHash
  pyimport :imagehash
  pyfrom :PIL, import: :Image

  def self.hash_map(target_path)
    @duplicateds = []
    phash_map = {}
    Dir.glob(File.join(target_path, '*.jpg')) do |filepath|
      filename = File.basename(filepath)
      pyimage = Image.open(filepath)
      phash = imagehash.phash(pyimage).to_s
      if phash_map[phash]
        FileUtils.rm(filepath)
        @duplicateds << filename
      else
        phash_map[phash] = filename
      end
    end
    @duplicateds.each do |filename|
      puts "delete! duplicated: #{filename}"
    end
    phash_map
  end
end
