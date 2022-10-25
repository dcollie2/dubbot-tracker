class AddSizeGroupToScan < ActiveRecord::Migration[7.0]
  def up
    add_column :scans, :size_group, :integer
    Scan.all.each do |scan|
      scan.save
    end
  end

  def down
    remove_column :scans, :size_group
  end
end
