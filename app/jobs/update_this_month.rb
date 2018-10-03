class UpdateThisMonth
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(thismonth: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today - 30.days..Date.today).joins(:visit).size)
    end
  end
end
