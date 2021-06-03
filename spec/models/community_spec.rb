# == Schema Information
#
# Table name: communities
#
#  id                 :bigint           not null, primary key
#  name               :string           not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  community_owner_id :bigint
#
# Indexes
#
#  index_communities_on_community_owner_id  (community_owner_id)
#  index_communities_on_name                (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (community_owner_id => users.id)
#
require "rails_helper"

RSpec.describe Community, type: :model do
  describe "バリデーションのチェック" do
    subject { community }

    context "コミュニティ名が50文字以下の時" do
      let(:community) { build(:community, name: "a" * 50) }
      it "コミュニティが登録される" do
        expect(subject).to be_valid
      end
    end

    context "コミュニティ名が50文字を超える時" do
      let(:community) { build(:community, name: "a" * 51) }
      it "コミュニティ登録ができない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :too_long
      end
    end

    context "名前が重複していないコミュニティが作成された時" do
      let(:other_community) { create(:community, name: "コミュニティA") }
      let(:community) { build(:community, name: "コミュニティB") }
      it "コミュニティが登録される" do
        other_community
        expect(subject).to be_valid
      end
    end

    context "名前が重複するコミュニティが作成された時" do
      let(:other_community) { create(:community, name: "コミュニティA") }
      let(:community) { build(:community, name: "コミュニティA") }
      it "コミュニティ登録ができない" do
        other_community
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :taken
      end
    end

    context "コミュニティ名がない時" do
      let(:community) { build(:community, name: nil) }
      it "コミュニティ登録ができない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:name][0][:error]).to eq :blank
      end
    end

    context "community_owner_id が存在しない時" do
      let(:community) { build(:community, community_owner_id: nil) }
      it "コミュニティ登録ができない" do
        expect(subject).not_to be_valid
        expect(subject.errors.details[:community_owner][0][:error]).to eq :blank
      end
    end
  end
end
