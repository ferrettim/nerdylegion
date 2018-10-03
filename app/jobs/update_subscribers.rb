class UpdateSubscribers
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(subscribers: Ahoy::Event.where(name: podcast.title.to_s).where(time: Date.today.beginning_of_day - 7.days..Date.today.end_of_day).joins(:visit).pluck(:ip).uniq.count)
    end
  end
end
