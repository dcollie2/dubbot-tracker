class System < ApplicationRecord
  has_many :sites, dependent: :nullify
  has_many :scans, through: :sites

  def current_pages
    scans.most_recent.sum(:pages)
  end

  def current_overall_score
    scans.most_recent.average(:overall_score).round(2) if scans.most_recent.present?
  end

  def current_broken_links
    scans.most_recent.sum(:broken_links)
  end

  def current_accessibility_issues
    scans.most_recent.sum(:accessibility_issues)
  end

  def current_misspellings
    scans.most_recent.sum(:misspellings)
  end
end
