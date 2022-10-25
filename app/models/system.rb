class System < ApplicationRecord
  has_many :sites, dependent: :nullify
  has_many :scans, through: :sites

  validates :name, uniqueness: true

  def current_pages
    scans.most_recent.sum(:pages) || 0
  end

  def current_overall_score
    score = scans.most_recent.average(:overall_score).round(2) if scans.most_recent.present?
    score = 0 if score.blank?
    score
  end

  def current_broken_links
    scans.most_recent.sum(:broken_links) || 0
  end

  def current_accessibility_issues
    scans.most_recent.sum(:accessibility_issues) || 0
  end

  def current_misspellings
    scans.most_recent.sum(:misspellings) || 0
  end
end
