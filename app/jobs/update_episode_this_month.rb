class UpdateEpisodeThisMonth
  include Sidekiq::Worker
  def perform
    episodes = Episode.where(status: "Published").where(published_on: Date.today - 90.days..Date.today.end_of_day)
    episodes.each do |episode|
      episode.update_attributes(thismonth: Ahoy::Event.where(time: Date.today - 30.days..Date.today.end_of_day).where(name: episode.podcast.title.to_s).where_props(episode: episode.episode.to_s).joins(:visit).count)
    end
  end
end
