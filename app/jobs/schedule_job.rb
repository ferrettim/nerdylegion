class ScheduleJob < ActiveJob::Base
  queue_as :default

  def perform(episode)
    episode.publish
  end
end
