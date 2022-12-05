class Site < ApplicationRecord
  has_many :scans
  belongs_to :system, optional: true
  validates :dubbot_id, presence: true, uniqueness: true
  delegate :name, to: :system, prefix: true, allow_nil: true

  scope :missing_system, -> { where.missing(:system) }
  scope :omit_homepages, -> { where("lower(sites.name) not like '%homepage%' and lower(sites.name) not like '%home page%'")}

  def current_page_count
    scans.blank? ? 0 : scans.order(:created_at).last.pages
  end
  class << self
    def import_sites(sites)
      sites.each do |site|
        # find or create site by dubbot_id
        target_site = Site.find_or_create_by(dubbot_id: site['models.id'])
        puts "#{site['Name']} - #{site['URL']}"
        target_site.update(name: site['Name'], url: site['URL'], last_crawl_at: site['Last Crawl'], next_crawl_at: site['Next Crawl'], enabled: site['Enabled'])
      end
    end
  end
end
