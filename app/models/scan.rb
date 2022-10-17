class Scan < ApplicationRecord
  belongs_to :site

  class << self
    def new_batch_number
      Scan.first.present? ? self.maximum(:batch_number) + 1 : 1
    end

    def import_scans(scans)
      batch_number = Scan.new_batch_number
      scans.each do |scan|
        # find or create site by dubbot_id
        site = Site.find_or_create_by(dubbot_id: scan['ID'])
        site.update(name: scan['Name'])
        site.scans.create(batch_number: batch_number, pages: scan['Pages'], overall_score: scan['Overall Score'], accessibility_issues: scan['Accessibility Issues'], broken_links: scan['Broken Links'], misspellings: scan['Misspellings'], flagged_words: scan['Flagged Words'])
      end
    end
  end

end
