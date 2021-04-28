if User.all.blank?
  ActiveRecord::Base.transaction do
    ##########################################
    # Userの作成
    ##########################################
    user = User.create!(email: "yamada@example.com", name: "山田 太郎", password: "password")
    User.create!(email: "suzuki@example.com", name: "鈴木 次郎", password: "password")
    User.create!(email: "satou@example.com", name: "佐藤 三郎", password: "password")

    ##########################################
    # UserDirectoryの作成
    ##########################################
    #######################
    # 親ディレクトリ(第1階層)
    #######################
    dev_directory = user.user_directories.create!(name: "開発")
    manual_directory = user.user_directories.create!(name: "マニュアル")

    #######################
    # 子ディレクトリ(第2階層)
    #######################
    # 開発ディレクトリの子ディレクトリ
    design_directory = dev_directory.children.create!(name: "設計", user: dev_directory.user)
    dev_directory.children.create!(name: "議事録", user: dev_directory.user)

    # マニュアルディレクトリの子ディレクトリ
    process_directory = manual_directory.children.create!(name: "手順", user: manual_directory.user)
    manual_directory.children.create!(name: "疑問点", user: dev_directory.user)

    #######################
    # 孫ディレクトリ(第3階層)
    #######################
    # 開発ディレクトリの孫ディレクトリ
    # 設計ディレクトリの子ディレクトリ
    wireframe_directory = design_directory.children.create!(name: "ワイヤーフレーム", user: dev_directory.user)
    design_directory.children.create!(name: "ドキュメント", user: dev_directory.user)

    # マニュアルディレクトリの孫ディレクトリ
    # 手順ディレクトリの子ディレクトリ
    initsetting_directory = process_directory.children.create!(name: "初期設定", user: manual_directory.user)
    process_directory.children.create!(name: "環境構築", user: dev_directory.user)

    #######################
    # 曾孫ディレクトリ(第4階層)
    #######################
    # 開発ディレクトリの曾孫ディレクトリ
    # 設計ディレクトリの孫ディレクトリ
    # ワイヤーフレームディレクトリの子ディレクトリ
    erdiagram_directory = wireframe_directory.children.create!(name: "ER図", user: dev_directory.user)
    wireframe_directory.children.create!(name: "UI", user: dev_directory.user)

    #######################
    # 曾孫ディレクトリ(第5階層)
    #######################
    # 開発ディレクトリの玄孫ディレクトリ
    # 設計ディレクトリの曾孫ディレクトリ
    # ワイヤーフレームディレクトリの孫ディレクトリ
    # ER図ディレクトリの子ディレクトリ
    draft_directory = erdiagram_directory.children.create!(name: "下書き", user: dev_directory.user)

    puts "初期データの投入に成功しました！"
  end
else
  puts <<~EOS
    既にデータは存在しています。
    下記コマンドを実行してデータを削除してから再読み込みしてください。
    bundle exec rails db:migrate:reset
  EOS
end
