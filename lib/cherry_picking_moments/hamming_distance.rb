class CherryPickingMoments::HammingDistance
  def initialize(source, compared)
    @source = source
    @compared = compared
  end

  def hamming_distance
    @source.to_binary.split('').zip(@compared.to_binary.split('')).count { |i, j| i.to_i ^ j.to_i == 1 }
  end
end
