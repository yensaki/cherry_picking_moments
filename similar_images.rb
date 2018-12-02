class SimilarImages
  attr_reader :deleted_nearies

  def initialize(phash_map, dir_path)
    @phash_map = phash_map
    # @filename_index = {}
    @filenames = phash_map.keys.sort
    @dir_path = dir_path
    @deleted_nearies = []
  end

  def uniquish!
    @filenames.each do |filename_a|
      filepath_a = File.join(@dir_path, filename_a)
      next unless File.exist?(filepath_a)
      phash_a = @phash_map[filename_a]
      # next if duplicateds.include?(phash_a)

      @filenames.each do |filename_b|
        next if filename_a == filename_b
        filepath_b = File.join(@dir_path, filename_b)
        next unless File.exist?(filepath_b)

        phash_b = @phash_map[filename_b]
        # next if duplicateds.include?(phash_b)
        diff =  hamming_distance(to_binary(phash_a), to_binary(phash_b))
        puts "#{diff}, file: #{filename_a}: #{phash_a}, #{filename_b}: #{phash_b}"
        if diff <= 20
          puts "delete! #{filename_b}"
          FileUtils.rm(filepath_b)
          @deleted_nearies << phash_b
        end
      end
      @filenames.delete(filename_a)
    end
  end

  private

  def to_binary(phash)
    sprintf("%064b", phash.to_i(16))
  end

  def hamming_distance(source, compared)
    source.split('').zip(compared.split('')).count { |i, j| i.to_i ^ j.to_i == 1 }
  end
end
