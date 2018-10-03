json.episodes do
  json.array!(@episodes) do |episode|
    json.title "#{episode.title}"
    json.icon "#{episode.podcast.logourl.thumb}"
    json.url episode_path(episode)
  end
end

json.podcasts do
  json.array!(@podcasts) do |podcast|
    json.title "#{podcast.title}"
    json.icon "#{podcast.logourl.thumb}"
    json.url podcast_path(podcast)
  end
end
