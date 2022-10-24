class System < ApplicationRecord
  has_many :sites, dependent: :nullify
  has_many :scans, through: :sites
end
