# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  image                  :string
#  name                   :string           not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  unconfirmed_email      :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_confirmation_token    (confirmation_token) UNIQUE
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe User, type: :model do
  describe "バリデーションのチェック" do
    subject { user }

    context "必要な情報が入力されている時" do
      let(:user) { build(:user) }
      it "ユーザーが作成される" do
        expect(subject).to be_valid
      end
    end

    context "nameが入力されていない時" do
      let(:user) { build(:user, name: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context "emailが入力されていない時" do
      let(:user) { build(:user, email: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:email][0][:error]).to eq :blank
      end
    end

    context "passwordが入力されていない時" do
      let(:user) { build(:user, password: nil) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:password][0][:error]).to eq :blank
      end
    end

    context "nameが20文字以下の時" do
      let(:user) { build(:user, name: "A" * 20) }
      it "ユーザーが作成される" do
        expect(subject).to be_valid
      end
    end

    context "nameが21文字以上の時" do
      let(:user) { build(:user, name: "A" * 21) }
      it "ユーザーが作成されない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :too_long
      end
    end
  end
end
