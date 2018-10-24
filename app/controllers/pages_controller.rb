class PagesController < ApplicationController
  layout nil, :only => [:sitemap]
  before_action :authenticate_user!, only: [:analytics]

  def privacy
  end

  def terms
  end

  def user_admin
    if user_signed_in? && current_user.admin?
      @pagy, @users = pagy(User.where.not(admin: true).order(name: :asc), items: 15)
      def destroy_user
        User.find(params[:id]).destroy
        redirect_to user_admin_path, :flash => { :success => "Success! User has been removed" }
      end
      def podcaster_true
        User.find(params[:id]).update_column(:podcaster, true)
        redirect_to user_admin_path, :flash => { :success => "Success! User has been upgraded to podcaster!" }
      end
      def podcaster_false
        User.find(params[:id]).update_column(:podcaster, false)
        redirect_to user_admin_path, :flash => { :success => "Success! User is no longer a podcaster!" }
      end
      def analytics_true
        User.find(params[:id]).update_column(:analytics, true)
        redirect_to user_admin_path, :flash => { :success => "Success! User has been granted analytics access!" }
      end
      def analytics_false
        User.find(params[:id]).update_column(:analytics, false)
        redirect_to user_admin_path, :flash => { :success => "Success! User access to analytics has been revoked!" }
      end
      def admin_true
        User.find(params[:id]).update_column(:admin, true)
        redirect_to user_admin_path, :flash => { :success => "Success! User has been granted admin priviledges!" }
      end
      def admin_false
        User.find(params[:id]).update_column(:admin, false)
        redirect_to user_admin_path, :flash => { :success => "Success! User admin priviledges have been revoked!" }
      end
    else
      redirect_to root_url
    end
  end

  def user_admin_new
    if user_signed_in? && current_user.admin?
      def create_user
        User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation], invite: ENV["INVITE_CODE"])
        redirect_to user_admin_path, :flash => { :success => "Success! New user has been created!" }
      end
    else
      redirect_to root_url
    end
  end

  def subscribe
    @podcasts = Podcast.where(status: "Published").order(title: :asc)
  end

  def analytics
    if user_signed_in? && current_user.analytics?
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
    @static_pages = [aboutus_path, subscribe_path, privacypolicy_path, termsofservice_path]
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

end
