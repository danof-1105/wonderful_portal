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
    subject { user_directory }

    context "name が20文字以下のとき" do
      let(:user_directory) { build(:user_directory) }
      it "ユーザーディレクトリが作られる" do
        expect(subject).to be_valid
      end
    end

    context "name が21文字以上のとき" do
      let(:user_directory) { build(:user_directory, name: "A" * 21) }
      it "ユーザーディレクトリが作られない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context "name が空のとき" do
      let(:user_directory) { build(:user_directory, name: nil) }
      it "ユーザーディレクトリが作られない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context "user_id が空のとき" do
      let(:user_directory) { build(:user_directory, user_id: nil) }
      it "ユーザーディレクトリが作られない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:user][0][:error]).to eq :blank
      end
    end
  end
end
