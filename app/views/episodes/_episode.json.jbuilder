json.extract! episode, :id, :podcast_id, :episode, :title, :description, :published_on, :status, :created_at, :updated_at
json.url episode_url(episode, format: :json)
