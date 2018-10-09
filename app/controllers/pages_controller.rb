class PagesController < ApplicationController
  layout nil, :only => [:sitemap]
  before_action :authenticate_user!, only: [:analytics]

  def hosts
    @users = User.where(podcaster: true).order(name: :asc)
  end

  def privacy
  end

  def terms
  end

  def subscribe
    @podcasts = Podcast.where(status: "Published").order(title: :asc)
  end

  def analytics
    if user_signed_in? && current_user.podcaster?
      @optionstitle = Podcast.where(status: "Published").order(title: :asc)
        if params[:name].present?
          @podcast = Podcast.where(status: "Published").where(title: params[:name]).first
          @episodes = Episode.where(podcast_id: @podcast.id).where(published_on: Date.today.beginning_of_month..Date.today.end_of_month)
          @platforms = Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today).joins(:visit).where.not(visits: { city: nil }).where.not(visits: { browser: "Other"}).top(:browser, 7)
          @locations = Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today).joins(:visit).where.not(visits: { city: nil }).group(:country).size
        else
          @subscribers = Podcast.where(status: "Published").order(subscribers: :desc)
          @average = Podcast.where(status: "Published").order(average: :desc)
          @topweek = Podcast.where(status: "Published").order(thisweek: :desc)
          # @topmonth = Podcast.where(status: "Published").order(thismonth: :desc)
        end
    else
      redirect_to root_url
    end
  end

  def allpodcasts
    chart_data = Ahoy::Event.joins(:visit)
                     .where(visits: {started_at: (Date.today - 1.year)..Date.today.end_of_day}).map {|m|
                       {name: m.name, data: {m.time => (Ahoy::Event.joins(:visit).where(time: m.time).where(name: m.name).count)}}}
    render json: chart_data.group_by {|e| e[:name]}
      .map {|k, v| {name: k, data: v.map {|e| e[:data]}.reduce(&:merge)}}.chart_json
  end

  def downloads
    render json: Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today.end_of_day).joins(:visit).group_by_day(:time)
  end

  def locations
    render json: Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today.end_of_day).joins(:visit).group(:country).size
  end

  def platforms
    render json: Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today.end_of_day).joins(:visit).top(:browser, 7)
  end

  def timeofday
    render json: Ahoy::Event.where(name: params[:name]).where(time: Date.today - 7.days..Date.today.end_of_day).joins(:visit).group_by_hour_of_day(:time)
  end

  def sitemap
    @static_pages = [privacy_path, terms_path, hosts_path]
    @episodes = Episode.where(status: "Published")
    respond_to do |format|
      format.xml
    end
  end

  def robots
    expires_in 6.hours, public: true
    respond_to do |format|
      format.text
    end
  end

  def membership
  end

  def digitalocean
    redirect_to "https://m.do.co/c/2596b51ba2f2"
  end

  def audible
    redirect_to "https://www.amazon.com/Audible-Free-Trial-Digital-Membership/dp/B00NB86OYE/?ref_=assoc_tag_ph_1485906643682&_encoding=UTF8&camp=1789&creative=9325&linkCode=pf4&tag=nerdylegion-20&linkId=0ae98708666f76c3361aa8e3980d1dc9"
  end

end
