# == Schema Information
#
# Table name: documents
#
#  id                :bigint           not null, primary key
#  body              :text
#  owner_type        :string           not null
#  title             :string           not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  owner_id          :bigint           not null
#  user_directory_id :bigint           not null
#  writer_id         :bigint           not null
#
# Indexes
#
#  index_documents_on_owner              (owner_type,owner_id)
#  index_documents_on_user_directory_id  (user_directory_id)
#  index_documents_on_writer_id          (writer_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_directory_id => user_directories.id)
#  fk_rails_...  (writer_id => users.id)
#
require "rails_helper"

RSpec.describe Document, type: :model do
  describe "バリデーションのチェック" do
    subject { document }

    context "title が50文字以内のとき" do
      let(:document) { build(:document, title: "A" * 50) }
      it "Documentを保存する" do
        expect(subject).to be_valid
      end
    end

    context "title が51文字以上のとき" do
      let(:document) { build(:document, title: "A" * 51) }
      it "Documentを保存されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:title][0][:error]).to eq :too_long
      end
    end

    context "title が空のとき" do
      let(:document) { build(:document, title: nil) }
      it "Documentを保存されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:title][0][:error]).to eq :blank
      end
    end
  end
end
