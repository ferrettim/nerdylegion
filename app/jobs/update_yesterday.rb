class UpdateYesterday
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(yesterday: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today.beginning_of_day - 1.day..Date.today.end_of_day - 1.day).joins(:visit).size)
    end
  end
end
