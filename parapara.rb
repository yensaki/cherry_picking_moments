require "open3"
require "fileutils"

class Parapara
  def initialize(file, output_path, rate: 3)
    @file = file
    @output_path = output_path
    @rate = rate
  end

  def slice!
    tmpdir = File.join("/tmp", "parapara_#{Time.now.to_i}")
    FileUtils.mkdir_p(tmpdir)
    cmd = "ffmpeg -ss 0 -i #{@file} -vsync 2 -r #{@rate} -an -f image2 '#{File.join(tmpdir, "%04d.png")}'"
    _output, _error, _status = Open3.capture3(cmd)

    Dir.glob(File.join(tmpdir, "*.png")) do |filepath|
      output_base_name = File.basename(filepath).gsub("png", "jpg")
      outout_file_path = File.join(@output_path, output_base_name)
      Open3.capture3("convert #{filepath} -resize 960x540 #{outout_file_path}")
      File.delete(filepath)
    end
    Dir.rmdir(tmpdir)
  end
end
