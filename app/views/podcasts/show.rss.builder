#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss( :version=>"2.0", :"xmlns:atom"=>"http://www.w3.org/2005/Atom", :"xmlns:itunes"=>"http://www.itunes.com/dtds/podcast-1.0.dtd" ) do
  xml.channel do
    xml.atom(:link, :href=> request.original_url, :rel => "self", :type => "application/rss+xml" )
    xml.image do
      xml.url @podcast.logourl.to_s
      xml.title @podcast.title
      xml.link root_url + "podcasts/" + @podcast.slug.to_s
      xml.width "1400"
      xml.height "1400"
    end
    xml.title @podcast.title
    xml.itunes :author, @podcast.email
    xml.description strip_tags(@podcast.description)
    xml.itunes :summary, strip_tags(@podcast.description)
    xml.itunes :subtitle, strip_tags(@podcast.description.truncate(255))
    if @podcast.mature == true
      xml.itunes :explicit, "yes"
    else
      xml.itunes :explicit, "no"
    end
    xml.itunes :owner do
        xml.itunes :name, @podcast.title
        xml.itunes :email, @podcast.email
    end
    xml.link root_url + "podcasts/" + @podcast.slug.to_s
    xml.category @podcast.genre
    xml.itunes :category, :text => @podcast.genre
    xml.copyright "@ " + DateTime.now.strftime("%Y") + " Nerdy Legion"
    xml.language "en-us"
    xml.webMaster @podcast.email + "(" + @podcast.title + ")"
    xml.managingEditor @podcast.email + "(" + @podcast.title + ")"
    xml.lastBuildDate @podcast.episodes.last.published_on.to_s(:rfc822) if @podcast.episodes.count > 0
    xml.ttl "30"

    for article in @podcast.episodes.where(status: "Published").limit(25).order(published_on: :desc)
      xml.item do
        if article.itunestype?
          xml.itunes :type, article.itunestype.to_s
        end
        if article.explicit?
          xml.itunes :explicit, article.explicit.to_s
        end
        if article.episodetype?
          xml.itunes :episodeType, article.episodetype.to_s
        end
        xml.itunes :episode, article.episode.to_s
        xml.itunes :title, article.title.to_s
        xml.title article.title.to_s
        xml.author @podcast.email + "(" + @podcast.title + ")"
        xml.pubDate article.published_on.to_s(:rfc822) if @podcast.episodes.count > 0
        xml.itunes :author, article.podcast.title
        xml.link root_url + "episodes/" + article.slug.to_s
        xml.itunes :image, :href => article.podcast.logourl.to_s
        feedsum = strip_tags(article.description)
        xml.itunes :summary, feedsum
        xml.itunes :subtitle, feedsum.truncate(255).html_safe
        if article.duration?
          xml.enclosure( :url => article.audiourl.to_s, :length => article.duration.to_s, :type => "audio/mpeg" )
        else
          xml.enclosure( :url => article.audiourl.to_s, :length => "00:00", :type => "audio/mpeg" )
        end
        xml.itunes :duration, article.duration.to_s
        if @podcast.patreon?
          xml.description feedsum + "<br /><br /> You can support this show by visiting our <a href='https://nerdylegion.threadless.com'>merch store</a>, directly <a href='" + @podcast.patreon.to_s + "'>through Patreon</a>, or by leaving us an <a href='" + article.podcast.itunes.to_s + "'>Apple Podcasts review</a>."
        else
          xml.description feedsum + "<br /><br />You can support this show by visiting our <a href='https://nerdylegion.threadless.com'>merch store</a>, or by leaving us an <a href='" + article.podcast.itunes.to_s + "'>Apple Podcasts review</a>."
        end
        xml.guid  root_url + "episodes/" + article.slug
      end
    end
  end
end
