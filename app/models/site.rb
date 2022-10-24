class Site < ApplicationRecord
  has_many :scans
  belongs_to :system, optional: true
  validates :dubbot_id, presence: true, uniqueness: true

  def system_name
    'TBD'
    # delegate to system.name
  end
end
