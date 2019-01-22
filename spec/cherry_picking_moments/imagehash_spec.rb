require "spec_helper"

RSpec.describe CherryPickingMoments::ImageHash do
  describe 'phash_map' do
    subject { CherryPickingMoments::ImageHash.phash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({ 'bd86c2393dc6c239' => ['image001.png'] })
    end
  end

  describe 'dhash_map' do
    subject { CherryPickingMoments::ImageHash.dhash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({ '0000401616680000' => ['image001.png'] })
    end
  end

  describe 'ahash_map' do
    subject { CherryPickingMoments::ImageHash.ahash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({ 'ffffff8383ffffff' => ['image001.png'] })
    end
  end
end
