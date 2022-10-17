class CreateSites < ActiveRecord::Migration[7.0]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :url
      t.integer :system_id
      t.string :dubbot_id

      t.timestamps
    end
  end
end
