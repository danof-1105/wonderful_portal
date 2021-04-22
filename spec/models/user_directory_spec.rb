# == Schema Information
#
# Table name: user_directories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_user_directories_on_ancestry  (ancestry)
#  index_user_directories_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "rails_helper"

RSpec.describe UserDirectory, type: :model do
  describe "バリデーションのチェック" do
    subject { user_directory.valid? }

    context "name が２０文字以内のとき" do
      let(:user_directory) { build(:user_directory) }
      it "ユーザーディレクトリが作られる" do
        expect(subject).to eq true
      end
    end

    context "name が２０文字以上のとき" do
      let(:user_directory) { build(:user_directory, name: "ディレクトリ" * 30) }
      it "ユーザーディレクトリが作られない" do
        expect(subject).to eq false
        expect(user_directory.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context "name が空のとき" do
      let(:user_directory) { build(:user_directory, name: "") }
      it "ユーザーディレクトリが作られない" do
        expect(subject).to eq false
        expect(user_directory.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context "user_id が空のとき" do
      let(:user_directory) { build(:user_directory, user_id: "") }
      it "ユーザーディレクトリが作られない" do
        expect(subject).to eq false
        expect(user_directory.errors.details[:user][0][:error]).to eq :blank
      end
    end
  end
end
