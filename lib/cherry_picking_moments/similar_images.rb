require 'fileutils'

module CherryPickingMoments
  class SimilarImages
    attr_reader :deleted_nearies, :duplicateds

    def initialize(phash_map)
      @phash_map = phash_map
    end

    def calc_diff
      @phash_map.each.with_index do |phash, index|
        next_phash = @phash_map[index + 1]
        next unless next_phash

        diff = hamming_distance(to_binary(phash.phash), to_binary(next_phash.phash))
        phash.next_image_diff = diff
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
end
