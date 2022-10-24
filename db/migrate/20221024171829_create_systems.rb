class CreateSystems < ActiveRecord::Migration[7.0]
  def change
    create_table :systems do |t|
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
