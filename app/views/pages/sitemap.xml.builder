xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
  xml.urlset( :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9") do
  @static_pages.each do |page|
    xml.url do
      xml.loc "https://www.nerdylegion.com#{page}"
      xml.changefreq("monthly")
    end
  end
  @episodes.each do |e|
    xml.url do
      xml.loc root_url + "episodes/#{e.slug}"
      xml.lastmod e.updated_at.strftime("%Y-%m-%d")
      xml.changefreq("daily")
      xml.priority("1.0")
    end
  end
end
