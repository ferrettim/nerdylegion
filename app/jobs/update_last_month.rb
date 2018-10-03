class UpdateLastMonth
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(lastmonth: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today - 60.days..Date.today - 30.days).joins(:visit).size)
    end
  end
end
