require "open3"
require "fileutils"

module CherryPickingMoments
  class Parapara
    def initialize(file, output_path, rate: 3)
      @file = file
      @output_path = output_path
      @rate = rate
    end

    def slice!
      FileUtils.mkdir_p(@output_path)
      cmd = "ffmpeg -ss 0 -i #{@file} -vsync 2 -r #{@rate} -an -f image2 '#{File.join(@output_path, "%04d.png")}'"
      Open3.capture3(cmd)
    end
  end
end
