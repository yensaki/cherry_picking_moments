target_path = ARGV[0]
output, _err, _status = Open3.capture("python ./main.py #{target_path}")

# phah の組み合わせそれぞれでハミング距離を取る
# ハミング距離が近いものがあればそのセットの片方を削除

phashes = [].uniq
phash_file_paths = {}
simillaries = {}
duplicateds = []

def to_binary(phash)
  phash.to_i(16).to_s(2).split("").map(&:to_i)
end

def hamming_distance(a, b)
  a.zip(b).count { |i, j| i^j == 1 }
end

phashes.each do |a|
  next if duplicateds.include?(a)

  phash.each do |b|
    next if duplicateds.include?(a)
    next if a == b

    diff =  hamming_distance(to_binary(a), to_binary(b))
    if diff <= 10
      simillaries[a] ||= []
      simillaries[a] |= [a, b]
      duplicateds += [a, b]
    end
  end
end

simillaries.each do |_, array|
  array.delete(array.sample)
  array.each do |filepath|
    FileUtils.delete(filepath)
  end
end