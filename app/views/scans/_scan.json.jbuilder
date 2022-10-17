json.extract! scan, :id, :pages, :overall_score, :accessibility_issues, :misspellings, :flagged_words, :last_crawled_on, :site_id, :created_at, :updated_at
json.url scan_url(scan, format: :json)
