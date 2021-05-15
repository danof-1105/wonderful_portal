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

  # rubocop:disable RSpec/MultipleMemoizedHelpers
  describe "カスタムバリデーションのチェック" do
    let(:first_user_directory) { create(:user_directory) }
    let(:second_user_directory) { first_user_directory.children.create(name: "1", user: first_user_directory.user) }
    let(:third_user_directory) { second_user_directory.children.create(name: "2", user: second_user_directory.user) }
    let(:forth_user_directory) { third_user_directory.children.create(name: "3", user: third_user_directory.user) }
    let(:fifth_user_directory) { forth_user_directory.children.create(name: "4", user: forth_user_directory.user) }
    let(:six_user_directory) { fifth_user_directory.children.create(name: "5", user: fifth_user_directory.user) }

    context "ディレクトリの階層が５階層までのとき" do
      subject { fifth_user_directory }

      it "ユーザーディレクトリが作られる" do
        expect(subject).to be_valid
      end
    end

    context "ディレクトリの階層が６階層以上のとき" do
      subject { six_user_directory }

      it "ユーザーディレクトリは作られない" do
        expect(subject).not_to be_valid
      end
    end
  end
  # rubocop:enable RSpec/MultipleMemoizedHelpers
end
