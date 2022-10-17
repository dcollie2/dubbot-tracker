class AddBatchNumberToScans < ActiveRecord::Migration[7.0]
  def change
    add_column :scans, :batch_number, :integer
  end
end
