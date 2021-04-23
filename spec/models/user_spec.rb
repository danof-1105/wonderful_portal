# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションのチェック" do
    subject { user }

    context "必要な情報が入力されている時" do
      let(:user) { create(:user) }
      it "ユーザーが作成される" do
        expect(subject).to be_valid
      end
    end

    context "nameが入力されていない時" do
      let(:user) { create(:user, name: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject).to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "emailが入力されていない時" do
      let(:user) { create(:user, email: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject).to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "passwordが入力されていない時" do
      let(:user) { create(:user, password: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject).to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context "nameが20文字以下のとき" do
      let(:user) { create(:user) }
      it "ユーザーが作成される" do
        expect(subject).to be_valid
      end
    end

    context "nameが21文字以上のとき" do
      let(:user) { create(:user, name: "A" * 21) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject).to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
