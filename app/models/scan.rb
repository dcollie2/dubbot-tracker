class Scan < ApplicationRecord
  belongs_to :site

  class << self
    def most_recent_batch
      Scan.first.present? ? self.maximum(:batch_number) : 0
    end
    def new_batch_number
      most_recent_batch + 1
    end

    def import_scans(scans)
      batch_number = Scan.new_batch_number
      scans.each do |scan|
        # find or create site by dubbot_id
        site = Site.find_or_create_by(dubbot_id: scan['ID'])
        site.update(name: scan['Name'])
        site.scans.create(batch_number: batch_number, pages: cleanse_number(scan, 'Pages'), overall_score: cleanse_number(scan, 'Overall Score'), accessibility_issues: cleanse_number(scan, 'Accessibility Issues'), broken_links: cleanse_number(scan, 'Broken Links'), misspellings: cleanse_number(scan, 'Misspellings'), flagged_words: cleanse_number(scan, 'Flagged Words'))
      end
    end

    def cleanse_number(scan, value)
      scan[value].gsub(',','').to_i if scan[value].present?
    end

  end



  scope :most_recent, -> { where(batch_number: self.most_recent_batch) }

  def size_grouping
    if pages > 1000
      1
    elsif pages.between?(501,1000)
      2
    elsif pages.between?(101,500)
      3
    elsif pages.between?(1,100)
      4
    elsif pages == 0
      5
    else
      6
    end
  end


end
