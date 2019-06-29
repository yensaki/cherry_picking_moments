require 'cherry_picking_moments'

RSpec.describe CherryPickingMoments do
  it "has a version number" do
    expect(CherryPickingMoments::VERSION).not_to be nil
  end

  describe '#movie' do
    subject { movie.images }
    let(:movie) { CherryPickingMoments.movie(source_file_path) }
    let(:source_file_path) { Pathname(__dir__).join('fixtures/movie/sample.mp4') }

    it 'gets hamming_distances' do
      expect(subject.map(&:following_distance)).to eq [6, 20, 14, 14, 16, 8, 2, 8, 14, 8, 4, nil]
    end
  end
end
