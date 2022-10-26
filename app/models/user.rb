class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :registerable, :confirmable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable, :lockable, :recoverable

  validates :email, :admin, presence: true

  def set_default_role
    self.admin ||= :user
  end

  def admin?
    self.admin == true
  end
end
