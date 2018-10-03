class Episode < ApplicationRecord
  extend FriendlyId
	friendly_id :path, use: [:slugged, :finders]
  belongs_to :podcast
  before_validation :clean_up_status
  mount_uploader :audiourl, EpisodeUploader
  process_in_background :audiourl
  validates_presence_of :podcast_id, :episode, :title, :description, :published_on, :status, :episodetype, :audiourl
  after_create :update_slug, on: :create

  def update_slug
    unless slug.include? self.path.to_s
      self.slug = nil
      self.save
    end
  end

      def clean_up_status
        self.published_on = case status
                            when "Draft"
                              created_at
                            else
                              published_on
                            end
        true
      end

      def schedule
        if self.status == "Scheduled"
          begin
          	ScheduleJob.set(wait_until: published_on).perform_later(self)
          rescue Exception => e
          	self.update_attributes(status: "Scheduling-error")
          end
        else
          publish
        end
      end

      def publish
        unless self.status == "Draft"
        	begin
            if Rails.env.production?
              twitter = Twitter::REST::Client.new do |config|
                config.consumer_key        = ENV['TWITTER_KEY']
                config.consumer_secret     = ENV['TWITTER_SECRET']
                config.access_token        = ENV['TWITTER_TOKEN']
                config.access_token_secret = ENV['TWITTER_TOKEN_SECRET']
              end
              if self.podcast.twitter?
                if self.podcast.user2_id? && self.podcast.user3_id?
                  twitter.update("Just posted @" + self.podcast.twitter.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + ", @" + User.find(self.podcast.user2_id).twitter.to_s + " & @" + User.find(self.podcast.user3_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                elsif self.podcast.user2_id?
                  twitter.update("Just posted @" + self.podcast.twitter.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + " & @" + User.find(self.podcast.user2_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                else
                  twitter.update("Just posted @" + self.podcast.twitter.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                end
              else
                if self.podcast.user2_id? && self.podcast.user3_id?
                  twitter.update("Just posted " + self.podcast.title.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + ", @" + User.find(self.podcast.user2_id).twitter.to_s + " & @" + User.find(self.podcast.user3_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                elsif self.podcast.user2_id?
                  twitter.update("Just posted " + self.podcast.title.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + " & @" + User.find(self.podcast.user2_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                else
                  twitter.update("Just posted " + self.podcast.title.to_s + ": " + self.title.to_s.titleize + " with @" + User.find(self.podcast.user_id).twitter.to_s + " https://nerdylegion.com/episodes/" + self.slug.to_s)
                end
              end
            end
            self.update_attributes(status: "Published")
        	rescue Exception => e
            puts "!!!!!!!!!!!!!!!#{e.message}!!!!!!!!!!!!!!!"
            self.update_attributes(status: "Publishing-error")
        	end
        end
      end

      def slug_candidates
         [ :path ]
      end

end
