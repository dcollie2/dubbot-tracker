json.extract! site, :id, :name, :url, :system_id, :dubbot_id, :created_at, :updated_at
json.url site_url(site, format: :json)
