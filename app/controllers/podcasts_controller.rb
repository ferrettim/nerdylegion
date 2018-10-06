class PodcastsController < ApplicationController
  before_action :set_podcast, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  # GET /podcasts
  # GET /podcasts.json
  def index
    @podcasts = Podcast.all.where(status: "Published").order(title: :asc)
  end

  # GET /podcasts/1
  # GET /podcasts/1.json
  def show
    @host = User.where(id: @podcast.user_id)
    @host2 = User.where(id: @podcast.user2_id)
    @host3 = User.where(id: @podcast.user3_id)
    @producer = User.where(id: @podcast.producer_id)
    @last = @podcast.episodes.where(status: "Published").last
    @pagy, @episodes = pagy(@podcast.episodes.where(status: "Published").order(published_on: :desc), items: 5)
    unless user_signed_in? && current_user.podcaster?
      ahoy.track "#{@podcast.title.to_s}", podcast: "#{@podcast.title.to_s}"
    end
    respond_to do |format|
      format.html
      format.rss { render :layout => false }
    end
  end

  # GET /podcasts/new
  def new
    if user_signed_in? && current_user.admin?
      @podcast = Podcast.new
    else
      redirect_to root_url
    end
  end

  # GET /podcasts/1/edit
  def edit
    unless user_signed_in? && current_user.podcaster?
      redirect_to root_url
    end
  end

  # POST /podcasts
  # POST /podcasts.json
  def create
    @podcast = Podcast.new(podcast_params)
    respond_to do |format|
      if @podcast.save
        format.html { redirect_to @podcast, notice: 'Podcast was successfully created.' }
        format.json { render :show, status: :created, location: @podcast }
      else
        format.html { render :new }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /podcasts/1
  # PATCH/PUT /podcasts/1.json
  def update
    respond_to do |format|
      if @podcast.update(podcast_params)
        format.html { redirect_to @podcast, notice: 'Podcast was successfully updated.' }
        format.json { render :show, status: :ok, location: @podcast }
      else
        format.html { render :edit }
        format.json { render json: @podcast.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /podcasts/1
  # DELETE /podcasts/1.json
  def destroy
    @podcast.destroy
    respond_to do |format|
      format.html { redirect_to podcasts_url, notice: 'Podcast was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_podcast
      @podcast = Podcast.friendly.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def podcast_params
      params.require(:podcast).permit(:title, :description, :genre, :language, :mature, :status, :published_on, :twitter, :email, :google, :itunes, :spotify, :stitcher, :tunein, :youtube, :logo, :logourl, :path, :patreon, :user_id, :user2_id, :user3_id, :producer_id)
    end
end
