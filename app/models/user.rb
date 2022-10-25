class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable, :timeoutable

  validates :email, presence: true

  def set_default_role
    self.role ||= :user
  end

end
