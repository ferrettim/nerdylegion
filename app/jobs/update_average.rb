class UpdateAverage
  include Sidekiq::Worker
  def perform
    podcasts = Podcast.where(status: "Published")
    podcasts.each do |podcast|
      podcast.update_attributes(average: (Episode.where(podcast_id: podcast.id).where(published_on: Date.today - 30.days..Date.today.end_of_day).where(status: "Published").average(:thisweek).to_i))
    end
  end
end
