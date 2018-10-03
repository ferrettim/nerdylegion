class UpdateToday
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(today: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today.beginning_of_day..Date.today.end_of_day).joins(:visit).size)
    end
  end
end
