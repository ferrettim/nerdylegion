class UpdateThisWeek
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(thisweek: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today - 7.days..Date.today).joins(:visit).size)
    end
  end
end
