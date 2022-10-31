class AddLastCrawlToSites < ActiveRecord::Migration[7.0]
  def change
    add_column :sites, :last_crawl_at, :datetime
    add_column :sites, :next_crawl_at, :datetime
    add_column :sites, :enabled, :boolean
  end
end
