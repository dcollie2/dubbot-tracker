class Scan < ApplicationRecord
  belongs_to :site
  after_save :set_size_group

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
      scan[value].present? ? scan[value].gsub(',','').to_i : 0
    end

  end



  scope :most_recent, -> { where(batch_number: self.most_recent_batch) }
  scope :in_system, ->  (system_id) { includes(site: :system).where(system: {id: system_id})}

  def size_grouping
    if pages > 1000
      0
    elsif pages.between?(501,1000)
      1
    elsif pages.between?(101,500)
      2
    elsif pages.between?(1,100)
      3
    elsif pages == 0
      4
    else
      5
    end
  end

  def size_group_names
    %w[large medium small tiny empty error]
  end

  def size_group_name
    size_group_names[size_group] if size_group.present?
  end

  private

  def set_size_group
    update_column(:size_group, size_grouping)
  end


end
