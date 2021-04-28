if User.all.blank?
  ActiveRecord::Base.transaction do
    puts "初期データの投入に成功しました！"
  end
else
  puts <<~EOS
    既にデータは存在しています。
    下記コマンドを実行してデータを削除してから再読み込みしてください。
    bundle exec rails db:migrate:reset
  EOS
end
