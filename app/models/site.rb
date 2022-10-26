class Site < ApplicationRecord
  has_many :scans
  belongs_to :system, optional: true
  validates :dubbot_id, presence: true, uniqueness: true
  delegate :name, to: :system, prefix: true, allow_nil: true

  scope :missing_system, -> { where.missing(:system) }
  scope :omit_homepages, -> { where("lower(sites.name) not like '%homepage%' and lower(sites.name) not like '%home page%'")}
end
