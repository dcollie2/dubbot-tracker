class System < ApplicationRecord
  has_many :sites, dependent: :nullify
end
