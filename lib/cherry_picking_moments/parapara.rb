require "open3"
require "fileutils"
require 'tmpdir'

module CherryPickingMoments
  class Parapara
    attr_reader :output_path

    def initialize(file, rate: 3)
      @file = file
      @rate = rate
      @output_path = Dir.tmpdir
    end

    def slice!
      FileUtils.mkdir_p(@output_path)
      cmd = "ffmpeg -ss 0 -i #{@file} -vsync 2 -r #{@rate} -an -f image2 '#{File.join(@output_path, "%04d.png")}'"
      Open3.capture3(cmd)
    end
  end
end
