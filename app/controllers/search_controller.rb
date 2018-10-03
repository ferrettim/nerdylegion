class SearchController < ApplicationController
  def index
  end

  def search
    @episodes_count    = Episode.ransack(title_cont: params[:q]).result(distinct: true).count
    @pagy, @episodes    = pagy(Episode.ransack(title_cont: params[:q]).result(distinct: true), items: 5)
    @pagy, @podcasts    = pagy(Podcast.ransack(title_cont: params[:q]).result(distinct: true), items: 5)

    respond_to do |format|
      format.html {}
      format.json {
        @episodes   = @episodes.limit(5)
        @podcasts   = @podcasts.limit(5)
      }
    end
  end

end
