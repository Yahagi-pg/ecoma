Rails.application.routes.draw do
  ## 記事について
  # 新規投稿画面
  get "/posters/:server/new" => "posters#new"
  # 新規投稿
  post "/posters/:server" => "posters#create"
  # 鯖内の記事一覧
  get "/posters/:server" => "posters#index"
  # 指定の記事詳細
  get "/posters/:server/:id" => "posters#show"
  # 検索条件による検索
  get "/posters/:server/:category/:keyword" => "posters#search"
  # 記事の終了
  delete "/posters/:server/:id" => "posters#close"

  ## 返信について
  # 返信
  post "/posters/:server/:id/reply" => "reply#create"

  # テストデータ自動作成用
  get "/td/posters" => "pos_n#posters"
  get "/td/replies" => "pos_n#replies"
end
