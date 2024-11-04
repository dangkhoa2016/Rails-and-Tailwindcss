class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable

  validates :first_name, :last_name, presence: true

  enum role: { user: 'user', admin: 'admin' }

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  # Prevent sign in for newly registered users
  def active_for_authentication?
    super && active?
  end
end
