class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable

  validates :first_name, :last_name, presence: true
  validate :birth_date_range

  enum role: { user: 'user', admin: 'admin' }
  
  has_one_attached :profile_avatar
  validate :profile_avatar_content_type
  validate :profile_avatar_size


  def full_name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  # Prevent sign in for newly registered users
  def active_for_authentication?
    super && active?
  end
  
  def birth_date_range
    return unless birth_date.present?

    if birth_date > Date.today
      errors.add(:birth_date, 'cannot be in the future')
    elsif Date.today.year - birth_date.year < 18
      errors.add(:birth_date, 'must be at least 18 years old')
    end
  end

  def profile_avatar_content_type
    return unless profile_avatar.attached?

    if !profile_avatar.content_type.in?(%('image/png image/jpeg image/jpg'))
      errors.add(:avatar, 'must be a PNG or JPEG')
    end
  rescue ActiveStorage::FileNotFoundError
    errors.add(:avatar, 'could not be found')
  end

  def profile_avatar_size
    return unless profile_avatar.attached?

    if profile_avatar.byte_size > 5.megabytes
      errors.add(:avatar, 'size must be less than 5 MB')
    end
  rescue ActiveStorage::FileNotFoundError
    errors.add(:avatar, 'could not be found')
  end
end
