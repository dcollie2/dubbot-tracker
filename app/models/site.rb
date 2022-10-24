class Site < ApplicationRecord
  has_many :scans
  belongs_to :system, optional: true
  validates :dubbot_id, presence: true, uniqueness: true
  delegate :name, to: :system, prefix: true, allow_nil: true

end
