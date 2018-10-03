#encoding: UTF-8

xml.instruct! :xml, :version => "1.0"
xml.rss( :version=>"2.0", :"xmlns:atom"=>"http://www.w3.org/2005/Atom", :"xmlns:itunes"=>"http://www.itunes.com/dtds/podcast-1.0.dtd" ) do
  xml.channel do
    xml.atom(:link, :href=> request.original_url, :rel => "self", :type => "application/rss+xml" )
    xml.image do
      xml.url "https://nl1.nyc3.digitaloceanspaces.com/assets/nloffline.jpg"
      xml.title "Nerdy Legion Podcast Network"
      xml.link "https://nerdylegion.com"
      xml.width "1400"
      xml.height "1400"
    end
    xml.title "Nerdy Legion Podcast Network"
    xml.itunes :author, "nerdylegion@gmail.com"
    xml.description "Nerdy Legion Podcast Network"
    xml.itunes :summary, "Nerdy Legion Podcast Network"
    xml.itunes :subtitle, "Nerdy Legion all episodes feed"
    xml.itunes :owner do
        xml.itunes :name, "Nerdy Legion Podcast Network"
        xml.itunes :email, "nerdylegion@gmail.com"
    end
    xml.itunes :explicit, "yes"
    xml.link "https://nerdylegion.com"
    xml.category "Arts"
    xml.itunes :category, :text => "Arts"
    xml.copyright "@ " + DateTime.now.strftime("%Y") + " Nerdy Legion"
    xml.language "en-us"
    xml.webMaster "nerdylegion@gmail.com (Nerdy Legion)"
    xml.managingEditor "nerdylegion@gmail.com (Nerdy Legion)"
    xml.lastBuildDate @episodes.last.published_on.to_s(:rfc822)
    xml.ttl "30"
    xml.atom( :href => "https://nerdylegion.com/episodes.rss", :rel => "self", :type => "application/rss+xml" )
    for article in @episodes
      xml.item do
        ahoy.track "#{article.podcast.title.to_s}", episode: "#{article.episode.to_s}", title: "#{article.title.to_s}", value: "#{article.podcast.title.to_s} Ep #{article.episode.to_s}"
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
        xml.itunes :title, article.podcast.title.titleize + ": " + article.title.titleize.to_s
        xml.title article.podcast.title.titleize + ": " + article.title.titleize.to_s
        xml.author "nerdylegion@gmail.com (Nerdy Legion Podcast Network)"
        xml.pubDate article.published_on.to_s(:rfc822) if @episodes.count > 0
        xml.itunes :author, article.podcast.title
        xml.link root_url + "episodes/" + article.slug.to_s
        xml.itunes :image, :href => article.podcast.logourl.to_s
        feedsum = strip_tags(article.description)
        xml.itunes :summary, feedsum.html_safe
        xml.itunes :subtitle, feedsum.truncate(255).html_safe
        if article.duration?
          xml.enclosure( :url => article.audiourl.to_s, :length => article.duration.to_s, :type => "audio/mpeg" )
        else
          xml.enclosure( :url => article.audiourl.to_s, :length => "00:00", :type => "audio/mpeg" )
        end
        xml.itunes :duration, article.duration.to_s
        xml.description feedsum + " If you have a second and want to help out the show, please <a href='" + article.podcast.itunes.to_s + "'>leave us an iTunes review</a>."
        xml.guid  root_url + "episodes/" + article.slug
      end
    end
  end
end
