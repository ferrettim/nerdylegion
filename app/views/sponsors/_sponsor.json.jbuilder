json.extract! sponsor, :id, :name, :description, :link, :image, :status, :created_at, :updated_at
json.url sponsor_url(sponsor, format: :json)
