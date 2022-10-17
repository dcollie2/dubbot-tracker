class CreateScans < ActiveRecord::Migration[7.0]
  def change
    create_table :scans do |t|
      t.integer :pages
      t.integer :overall_score
      t.integer :broken_links
      t.integer :accessibility_issues
      t.integer :misspellings
      t.integer :flagged_words
      t.datetime :last_crawled_on
      t.integer :site_id

      t.timestamps
    end
  end
end
