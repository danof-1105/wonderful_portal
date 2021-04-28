if User.all.blank?
  ActiveRecord::Base.transaction do
    ##########################################
    # Userの作成
    ##########################################
    user = User.create!(email: "yamada@example.com", name: "山田 太郎", password: "password")
    user2 = User.create!(email: "suzuki@example.com", name: "鈴木 次郎", password: "password")
    user3 = User.create!(email: "satou@example.com", name: "佐藤 三郎", password: "password")

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
    manual_directory.children.create!(name: "疑問点", user: manual_directory.user)

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
    process_directory.children.create!(name: "環境構築", user: manual_directory.user)

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

    ##########################################
    # Communityの作成
    ##########################################
    community = Community.create!(name: "Wonderful-Portal")
    community2 = Community.create!(name: "Wonderful-Code")
    community3 = Community.create!(name: "Wonderfur-Editor")

    ##########################################
    # CommunityUserの作成
    ##########################################
    # WonderfulPortalコミュニティのユーザー
    CommunityUser.create!(community_id: community.id, user_id: user.id)
    CommunityUser.create!(community_id: community.id, user_id: user2.id)

    # WonderfulCodeコミュニティのユーザー
    CommunityUser.create!(community_id: community2.id, user_id: user2.id)
    CommunityUser.create!(community_id: community2.id, user_id: user3.id)

    ##########################################
    # CommunityDirectoryの作成
    ##########################################
    #######################
    # 親ディレクトリ(第1階層)
    #######################
    share_directory = community.community_directories.create!(name: "共有")
    private_directory = community.community_directories.create!(name: "個人")

    #######################
    # 子ディレクトリ(第2階層)
    #######################
    # 共有ディレクトリの子ディレクトリ
    team_development_directory = share_directory.children.create!(name: "チーム開発", community: share_directory.community)
    share_directory.children.create!(name: "コミュニティルール", community: share_directory.community)

    # 個人ディレクトリの子ディレクトリ
    person_directory = private_directory.children.create!(name: "山田さん", community: private_directory.community)
    private_directory.children.create!(name: "佐藤さん", community: private_directory.community)

    #######################
    # 孫ディレクトリ(第3階層)
    #######################
    # 共有ディレクトリの孫ディレクトリ
    # チーム開発ディレクトリの子ディレクトリ
    rule_directory = team_development_directory.children.create!(name: "規約", community: share_directory.community)
    team_development_directory.children.create!(name: "開発メンバー", community: share_directory.community)

    ##########################################
    # Documentの作成
    ##########################################
    # ユーザーディレクトリ内のドキュメント
    document = user.documents.create!(title: "ユーザードキュメント", body: "ユーザーの持つドキュメント" * 5, user_directory: design_directory, owner: user )
    document2 = user.documents.create!(title: "設計", body: "設計に関するテキスト" * 5, user_directory: design_directory, owner: user )
    document3 = user.documents.create!(title: "ワイヤーフレーム", body: "ワイヤーフレームに関するテキスト" * 5, user_directory: wireframe_directory, owner: user )

    ##########################################
    # CommunityDirectoryDocumentsの作成
    ##########################################
    CommunityDirectoryDocument.create!(document_id: document.id, community_directory_id: team_development_directory.id)
    CommunityDirectoryDocument.create!(document_id: document2.id, community_directory_id: team_development_directory.id)

    ##########################################
    # Commentの作成
    ##########################################
    document.comments.create!(body: "LGTMです！" * 10, user_id: user.id)
    document.comments.create!(body: "修正あり" * 10, user_id: user2.id)


    puts "初期データの投入に成功しました！"
  end
else
  puts <<~EOS
    既にデータは存在しています。
    下記コマンドを実行してデータを削除してから再読み込みしてください。
    bundle exec rails db:migrate:reset
  EOS
end
