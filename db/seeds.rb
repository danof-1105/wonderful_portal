if User.all.blank?
  ActiveRecord::Base.transaction do
    ##########################################
    # Userの作成
    ##########################################
    user = User.create!(email: "yamada@example.com", name: "山田 太郎", password: "password")
    User.create!(email: "suzuki@example.com", name: "鈴木 次郎", password: "password")
    User.create!(email: "satou@example.com", name: "佐藤 三郎", password: "password")

    puts "初期データの投入に成功しました！"
  end
else
  puts <<~EOS
    既にデータは存在しています。
    下記コマンドを実行してデータを削除してから再読み込みしてください。
    bundle exec rails db:migrate:reset
  EOS
end
