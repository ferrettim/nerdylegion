json.extract! podcast, :id, :title, :description, :genre, :language, :mature, :status, :published_on, :twitter, :google, :itunes, :stitcher, :tunein, :created_at, :updated_at
json.url podcast_url(podcast, format: :json)
