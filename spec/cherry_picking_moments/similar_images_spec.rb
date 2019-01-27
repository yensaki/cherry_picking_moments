require "spec_helper"

RSpec.describe CherryPickingMoments::SimilarImages do
  describe '#uniquish' do
    let(:instance) { CherryPickingMoments::SimilarImages.new(phash_map, dir_path) }
    subject do
      -> {
        instance.uniquish!(threshold: 10)
      }
    end
    let(:dir_path) { spec_dir.join("fixtures/images") }
    let(:filenames) { ["image001.png", "image002.png"] }

    around do |example|
      filenames.each { |filename| FileUtils.cp(dir_path.join(filename), dir_path.join("_#{filename}")) }
      example.run
      filenames.each { |filename| FileUtils.mv(dir_path.join("_#{filename}"), dir_path.join(filename)) }
    end

    context 'duplicated phash' do
      let(:phash_map) do
        { "bd86c2393dc6c239" => filenames }
      end

      it 'delete except one' do
        is_expected.to change { Dir.glob(dir_path.join("image*.png")).count }.from(2).to(1)
      end
    end
  end
end
