class UpdateLastWeek
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(lastweek: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today - 14.days..Date.today - 7.days).joins(:visit).size)
    end
  end
end
