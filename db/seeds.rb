require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'episodes.csv'))
csv = CSV.parse(csv_text, :headers => true, :encoding => 'UTF-8')
csv.each do |row|
  t = Episode.new
  t.podcast_id = row['podcast_id']
  t.episode = row['episode']
  t.title = row['title']
  t.description = row['description']
  t.status = row['status']
  t.published_on = row['published_on']
  t.created_at = row['created_at']
  t.updated_at = row['updated_at']
  t.slug = row['slug']
  t.audiourl = row['audiourl']
  t.save
  puts "Ep #{t.episode}: #{t.title} saved"
end

puts "There are now #{Episode.count} rows in the transactions table"
