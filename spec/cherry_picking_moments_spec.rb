require 'cherry_picking_moments'

RSpec.describe CherryPickingMoments do
  it "has a version number" do
    expect(CherryPickingMoments::VERSION).not_to be nil
  end

  describe '#hamming_distances' do
    subject { CherryPickingMoments.hamming_distances(source_file_path) }
    let(:source_file_path) { Pathname(__dir__).join('fixtures/movie/sample.mp4') }

    it 'gets hamming_distances' do
      expect(subject.map(&:following_distance)).to eq [12, 6, 8, 18, 14, 20, 26, 20, 20, 26, 8, nil]
    end
  end
end
