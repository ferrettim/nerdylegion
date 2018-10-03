module EpisodesHelper
  def status_for(episode)
    if episode.published_on?
      if episode.published_on > Time.zone.now
        "Scheduled"
      else
        "Published"
      end
    else
      "Draft"
    end
  end
end
