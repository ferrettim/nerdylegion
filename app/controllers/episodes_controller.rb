require 'open-uri'

class EpisodesController < ApplicationController
  before_action :set_episode, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :pending]

  # GET /episodes
  # GET /episodes.json
  def index
    if request.format.rss?
      @episodes = Episode.where(status: "Published").where(published_on: (DateTime.now - 30.days)..(DateTime.now)).limit(50).order(published_on: :desc)
    elsif request.format.json?
      @episodes = Episode.where(status: "Published").where(published_on: (DateTime.now - 30.days)..(DateTime.now)).limit(100).order(published_on: :desc)
    else
      @episodes = Episode.where(status: "Published").where(published_on: (DateTime.now - 8.days)..(DateTime.now)).order(published_on: :desc)
    end
  end

  def pending
    @episodes = Episode.where.not(status: "Published").order(published_on: :asc)
  end
  # GET /episodes/1
  # GET /episodes/1.json
  def show
    @previous = Episode.where(podcast_id: @episode.podcast.id).where(status: "Published").where(episode: @episode.episode - 1).first
    @next = Episode.where(podcast_id: @episode.podcast.id).where(status: "Published").where(episode: @episode.episode + 1).first
    unless user_signed_in? && current_user.podcaster?
      ahoy.track "#{@episode.podcast.title.to_s}", episode: "#{@episode.episode.to_s}", title: "#{@episode.title.to_s}", value: "#{@episode.podcast.title.to_s} Ep #{@episode.episode.to_s}"
    end
  end

  # GET /episodes/new
  def new
    if user_signed_in? && current_user.podcaster?
      @episode = Episode.new
      @podcast = Podcast.where(status: "Published")
    else
      redirect_to root_url
    end
  end

  # GET /episodes/1/edit
  def edit
    @podcast = Podcast.where(status: "Published")
  end

  # POST /episodes
  # POST /episodes.json
  def create
    if user_signed_in? && current_user.podcaster?
      @episode = Episode.new(episode_params)
      @podcast = Podcast.where(status: "Published").order(title: :asc)
      respond_to do |format|
        if @episode.save
          @episode.update_attributes(download_size: ((Mechanize.new.head( @episode.audiourl.to_s )["content-length"].to_i)/1024/1000))
          @episode.update_attributes(duration: Time.at(((Mechanize.new.head( @episode.audiourl.to_s )["content-length"].to_i)/1024*8.2/64)).utc.strftime('%H:%M:%S'))
          @episode.schedule
          format.html { redirect_to @episode, notice: 'Episode was successfully created.' }
          format.json { render :json => @episode }
        else
          format.html { render :new }
          format.json { render json: @episode.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    respond_to do |format|
      if @episode.update(episode_params)
        format.html { redirect_to @episode, notice: 'Episode was successfully updated.' }
        format.json { render :show, status: :ok, location: @episode }
      else
        format.html { render :edit }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    respond_to do |format|
      format.html { redirect_to episodes_url, notice: 'Episode was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:podcast_id, :episode, :title, :description, :published_on, :status, :path, :audio, :audiourl, :download_size, :duration, :itunestype, :episodetype, :explicit)
    end
end
