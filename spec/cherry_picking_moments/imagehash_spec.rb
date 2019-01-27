require "spec_helper"

RSpec.describe CherryPickingMoments::ImageHash do
  let(:target_filename) { 'image001.png' }
  around do |example|
    FileUtils.cp(target_path.join(target_filename), target_path.join('_image001.origin'))
    example.run
    FileUtils.mv(target_path.join('_image001.origin'), target_path.join(target_filename))
  end

  describe 'phash_map' do
    subject { CherryPickingMoments::ImageHash.phash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({ "bd86c2393dc6c239"=>["image001.png"], "d52928d6efa89427"=>["image002.png"] })
    end
  end

  describe 'dhash_map' do
    subject { CherryPickingMoments::ImageHash.dhash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({"0000401616680000"=>["image001.png"], "a449b44a4ab4b640"=>["image002.png"]})
    end
  end

  describe 'ahash_map' do
    subject { CherryPickingMoments::ImageHash.ahash_map(target_path) }
    let(:target_path) { spec_dir.join("fixtures/images") }
    it 'gets phash' do
      is_expected.to eq({"0000defbaefe0000"=>["image002.png"], "ffffff8383ffffff"=>["image001.png"]})
    end
  end
end
