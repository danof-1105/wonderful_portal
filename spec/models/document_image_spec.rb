# == Schema Information
#
# Table name: document_images
#
#  id          :bigint           not null, primary key
#  image       :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  document_id :bigint           not null
#
# Indexes
#
#  index_document_images_on_document_id  (document_id)
#
# Foreign Keys
#
#  fk_rails_...  (document_id => documents.id)
#
require "rails_helper"

RSpec.describe DocumentImage, type: :model do
  describe "バリデーションのテスト" do
    subject { document_image }

    context "image が存在する時" do
      let(:document_image) { build(:document_image) }
      it "document_image が登録される" do
        expect(subject).to be_valid
      end
    end

    context "image が存在しない時" do
      let(:document_image) { build(:document_image, image: nil) }
      it "document_image は登録できない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:image][0][:error]).to eq :blank
      end
    end
  end
end
