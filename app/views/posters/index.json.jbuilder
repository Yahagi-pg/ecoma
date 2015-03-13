json.array!(@posters) do |poster|
  json.extract! poster, :id, :category, :title, :contributor, :uid, :posted, :content, :delete_key, :closed, :previews
  json.url poster_url(poster, format: :json)
end
