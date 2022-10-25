task :assign_systems => :environment do
  require 'csv'

  CSV.foreach("#{Rails.root}/lib/tasks/site_systems.csv", :headers => true, encoding: 'utf-8') do |item|
    row = item.to_h
    if row['Name'].present?
      system = System.find_or_create_by!(name: row['System'])
      site = Site.find_by_name row['Name']
      puts "Site #{site.present?} - System #{system.present?} - #{system.id}"
      puts system.inspect
      site.update!(system_id: system.id)
      site.save!
    end
  end
end